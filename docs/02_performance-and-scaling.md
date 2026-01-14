# IN.IDEA: Performance and Scaling

> [!IMPORTANT]
> **Architectural Status:** The infrastructure described in this document—specifically the **Postgres-as-Single-Source-of-Truth (SSoT)** and the automated **ETL Pipeline** — is currently a **conceptual design**. It serves as a roadmap for implementation and is not yet part of the active codebase.

## 1. Core Objectives

The **IN.IDEA** graph model employs a deep layered architecture to preserve epistemic nuance. While this is ideal for data integrity, it introduces high "hop-counts" for standard queries. This strategy defines how we **denormalize** specific paths during the transfer from the relational SSoT to the Graph DB to achieve:

* **O(1) Hierarchy Lookups:** Bypassing recursive traversals in the Tree of Concepts.
* **Low-Latency Standard Views:** Providing direct access to high-certainty data for front-end consumers.
* **Reduced Computational Overhead:** Shifting complex logic from query-time to ingest-time.


## 2. Hierarchical Flattening (Materialized Paths)

To avoid expensive recursive `:IS_A` traversals within the `Concept` hierarchy, we implemented **Materialized Path Arrays**.

### Implementation: `concept_path_ids`

Each `Concept` node is enriched with a property containing its entire ancestral lineage.

* **Property:** `concept_path_ids`, Type: `LIST<INT>` (production) / `LIST<STRING>` (fixtures).
* **Content:** An array of all concept_ids in the path, including the node's own ID (e.g., `["self-id", "parent-id", "root-id"]`).
* **Technical Benefit:** Enables high-performance filtering using Neo4j's array indexing.


### Query Performance Analysis

> [!NOTE]
> **Benchmarking Disclaimer:** The millisecond values recorded here reflect the current fixture set and are intended solely to show relative acceleration. In a production environment, the execution plan structure is the primary indicator of performance rather than these specific timings.

---

#### 1. Traditional Query (Recursive Traversal)

This approach navigates the physical layers and then performs a recursive search up the taxonomic tree to identify objects.

```cypher
// TRADITIONAL APPROACH: Use recursive IS_A relationships
MATCH (u:Unit)-[:HAS_COMPOSITION]->(:Composition)-[:HAS_COMPOSITION_ENTITY]->(ce:CompositionEntity)
MATCH (ce)-[:HAS_INTERPRETATION]->(i:Interpretation)-[:IDENTIFIED_AS_CONCEPT]->(baseConcept:Concept)

// UPWARDS NAVIGATION: Traverse the hierarchy upwards to find the target ancestor
MATCH (baseConcept)-[:IS_A*0..]->(target:Concept {concept_id: 'concept-object'})

// OUTPUT: Retrieve the desired identification details
RETURN 
    u.unit_id AS Unit, 
    ce.composition_entity_id AS CompositionEntity, 
    i.certainty AS IdentificationCertainty, 
    baseConcept.concept_id AS IdentifiedConcept;

```

**Result Set** 

| Unit | CompositionEntity | IdentificationCertainty | IdentifiedConcept |
| --- | --- | --- | --- |
| "unit-apple-tomato" | "entity-at-apple-tomato" | 0.5 | "concept-tomato" |
| "unit-apple-tomato" | "entity-at-apple-tomato" | 0.4 | "concept-apple" |
| "unit-billiard-ball" | "entity-bb-billiard-ball-sphere" | 1.0 | "concept-billiard-ball-7" |

**Full Execution Profile**

| Operator | Id | Details | Rows | DB Hits |
| --- | --- | --- | --- | --- |
| ProduceResults | 0 | Unit, CompositionEntity, Certainty, IdentifiedConcept | 3 | 0 |
| Projection | 1 | u.unit_id, ce.composition_entity_id, i.certainty, baseConcept.concept_id | 3 | 12 |
| Filter | 2 | u:Unit | 3 | 3 |
| Expand(All) | 3 | (anon_1)<-[:HAS_COMPOSITION]-(u) | 3 | 25 |
| Filter | 4 | anon_1:Composition | 3 | 3 |
| Expand(All) | 5 | (ce)<-[:HAS_COMPOSITION_ENTITY]-(anon_1) | 3 | 19 |
| Filter | 6 | ce:CompositionEntity | 3 | 3 |
| Expand(All) | 7 | (i)<-[:HAS_INTERPRETATION]-(ce) | 3 | 18 |
| Filter | 8 | i:Interpretation | 3 | 3 |
| Expand(All) | 9 | (baseConcept)<-[:IDENTIFIED_AS_CONCEPT]-(i) | 3 | 23 |
| Filter | 10 | baseConcept:Concept | 7 | 7 |
| **VarLengthExpand(All)** | **11** | **(target)<-[:IS_A*0..]-(baseConcept)** | **7** | **13** |
| NodeUniqueIndexSeek | 12 | UNIQUE target:Concept(concept_id) WHERE concept_id = 'concept-object' | 1 | 2 |

**Total database accesses: 131** | **Execution time: ~63 ms**

**Commentary**

The critical bottleneck in this plan is the **VarLengthExpand(All)** operator (Id 11). This forces the database to perform a live, recursive search through the ontology for every potential result. While functional for small fixtures, this  operation scales poorly; as the taxonomy grows deeper, query latency increases linearly with each additional level in the hierarchy.

---

#### 2. Optimized Query (Materialized Path)

This approach leverages the **Hierarchical Flattening** strategy by checking a pre-calculated array of all ancestors stored on each concept node.

```cypher
// OPTIMIZED APPROACH: Use the index to find all concepts belonging to 'concept-object'
MATCH (c:Concept)
WHERE 'concept-object' IN c.concept_path_ids

// BACKWARDS NAVIGATION: Move from the semantic layer back to the physical data
MATCH (c)<-[:IDENTIFIED_AS_CONCEPT]-(i:Interpretation)
MATCH (i)<-[:HAS_INTERPRETATION]-(ce:CompositionEntity)
MATCH (ce)<-[:HAS_COMPOSITION_ENTITY]-(comp:Composition)<-[:HAS_COMPOSITION]-(u:Unit)

// OUTPUT: Retrieve the desired identification details
RETURN 
    u.unit_id AS Unit, 
    ce.composition_entity_id AS CompositionEntity, 
    i.certainty AS IdentificationCertainty, 
    c.concept_id AS IdentifiedConcept;

```

**Result Set** 

| Unit | CompositionEntity | IdentificationCertainty | IdentifiedConcept |
| --- | --- | --- | --- |
| "unit-apple-tomato" | "entity-at-apple-tomato" | 0.5 | "concept-tomato" |
| "unit-apple-tomato" | "entity-at-apple-tomato" | 0.4 | "concept-apple" |
| "unit-billiard-ball" | "entity-bb-billiard-ball-sphere" | 1.0 | "concept-billiard-ball-7" |

**Full Execution Profile**

| Operator | Id | Details | Rows | DB Hits |
| --- | --- | --- | --- | --- |
| ProduceResults | 0 | Unit, CompositionEntity, Certainty, IdentifiedConcept | 3 | 0 |
| Projection | 1 | u.unit_id, ce.composition_entity_id, i.certainty, baseConcept.concept_id | 3 | 12 |
| **Filter** | **2** | **'concept-object' IN baseConcept.concept_path_ids AND baseConcept:Concept** | **3** | **12** |
| Expand(All) | 3 | (i)-[:IDENTIFIED_AS_CONCEPT]->(baseConcept) | 9 | 50 |
| Filter | 4 | i:Interpretation | 9 | 9 |
| Expand(All) | 5 | (ce)-[:HAS_INTERPRETATION]->(i) | 9 | 36 |
| Filter | 6 | ce:CompositionEntity | 6 | 6 |
| Expand(All) | 7 | (anon_1)-[:HAS_COMPOSITION_ENTITY]->(ce) | 6 | 18 |
| Filter | 8 | (u:Unit AND anon_1:Composition) | 2 | 4 |
| DirectedRelationshipTypeScan | 9 | (u)-[:HAS_COMPOSITION]->(anon_1) | 2 | 3 |

**Total database accesses: 150** | **Execution time: ~12 ms**

**Commentary**

The recursive expander has been replaced by a local **Filter** (Id 2). This constitutes a **hierarchy lookup**; the cost to verify if a concept is an "object" is now constant and independent of the taxonomy's depth.

Although the total DB hits are slightly higher (150 vs 131), this is a deliberate choice by the **Cost-Based Optimizer (CBO)** for small datasets. Because the fixture set is tiny, the CBO determines that a full relationship scan (Id 9) is more efficient than the overhead of an index seek. In production environments with > 100k of `Unit` nodes, the CBO would pivot to an **Index Seek**, ensuring high-speed access that scales horizontally.


## 3. The Epistemic Bypass (Shortcut Relations)

The Epistemic Layer uses `Interpretation` nodes to model uncertainty. For the majority of end-user queries, we can bypass this layer when the data meets specific "Gold Standard" criteria.

### 3.1 Entity-to-Concept Shortcut

We collapse the path from a formal element to its semantic identification.

* **Source Node:** `CompositionEntity`.
* **Target Node:** `Concept`.
* **Relationship:** `HAS_CERTAIN_PRIMARY_CONCEPT`.
* **Materialization Trigger:**
  * `Interpretation.status == "Primary"`.
  * `Interpretation.certainty >= 0.8` (Current threshold).

### 3.2 Composition-to-Reading Shortcut

We bypass layout-based grouping nodes (e.g., `CompositionGroup`) to allow direct text-based filtering on the composition level.

* **Source Node:** `Composition`.
* **Target Node:** `Reading`.
* **Relationship:** `HAS_CERTAIN_PRIMARY_READING`.
* **Materialization Trigger:**
  * `Reading.status == "Primary"`.
  * `Reading.certainty >= 0.8` (Current threshold).


## 4. Proposed ETL Workflow (Conceptual)

The materialization logic resides entirely within the ETL (Extract, Transform, Load) pipeline.

| Step | Action | Description |
| --- | --- | --- |
| **1. Extract** | Daily Snapshot | Pull latest state from Postgres SSoT. |
| **2. Transform** | Path Calculation | Compute the `concept_path_ids` array using a recursive CTE in Postgres. |
| **3. Transform** | Shortcut Logic | Evaluate `status` and `certainty` thresholds to determine shortcut eligibility. |
| **4. Load** | Graph Rebuild | Wipe the Neo4j instance (or specific labels) and perform a high-speed `UNWIND` load. Use Blue-Green Deployment to avoid downtime |


## 5. Performance Monitoring

Post-materialization, the following indices must be maintained in Neo4j to ensure the effectiveness of this strategy:

* **Lookup Index:** On `Concept(concept_path_ids)`.
* **Constraint:** Unique IDs for all materialized relationships to prevent duplication during incremental updates (if implemented).
