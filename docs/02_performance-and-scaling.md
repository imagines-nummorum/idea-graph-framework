# IDEA: Performance and Scaling

> [!IMPORTANT]
> **Architectural Status:** The infrastructure described in this document—specifically the **Postgres-as-Single-Source-of-Truth (SSoT)** and the automated **ETL Pipeline** — is currently a **conceptual design**. It serves as a roadmap for implementation and is not yet part of the active codebase.

## 1. Core Objectives

The **IDEA** graph model employs a deep layered architecture to preserve epistemic nuance. While this is ideal for data integrity, it introduces high "hop-counts" for standard queries. This strategy defines how we **denormalize** specific paths during the transfer from the relational SSoT to the Graph DB to achieve:

* **O(1) Hierarchy Lookups:** Bypassing recursive traversals in the Tree of Concepts.
* **Low-Latency Standard Views:** Providing direct access to high-certainty data for front-end consumers.
* **Reduced Computational Overhead:** Shifting complex logic from query-time to ingest-time.

---

## 2. Hierarchical Flattening (Materialized Paths)

To avoid expensive recursive `:IS_A` traversals within the `Concept` hierarchy, we implement **Materialized Path Arrays**.

### Implementation: `concept_path_ids`

Each `Concept` node will be enriched with a property containing its entire ancestral lineage.

* **Property:** `concept_path_ids` (Type: `LIST<STRING>` or `LIST<INT>`).
* **Content:** An ordered array starting from the root concept down to the node's own ID (e.g., `["root-id", "parent-id", "self-id"]`).
* **Technical Benefit:** Enables high-performance filtering using Neo4j's array indexing.
* *Query Example:* `MATCH (n:Concept) WHERE 'target-concept-id' IN n.concept_path_ids` instead of `MATCH (n:Concept)-[:IS_A*]->(t:Concept {concept_id: 'target-concept-id'})`.

---

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

---

## 4. Proposed ETL Workflow (Conceptual)

The materialization logic resides entirely within the ETL (Extract, Transform, Load) pipeline.

| Step | Action | Description |
| --- | --- | --- |
| **1. Extract** | Daily Snapshot | Pull latest state from Postgres SSoT. |
| **2. Transform** | Path Calculation | Compute the `concept_path_ids` array using a recursive CTE in Postgres. |
| **3. Transform** | Shortcut Logic | Evaluate `status` and `certainty` thresholds to determine shortcut eligibility. |
| **4. Load** | Graph Rebuild | Wipe the Neo4j instance (or specific labels) and perform a high-speed `UNWIND` load. |

---

## 5. Performance Monitoring

Post-materialization, the following indices must be maintained in Neo4j to ensure the effectiveness of this strategy:

* **Lookup Index:** On `Concept(concept_path_ids)`.
* **Constraint:** Unique IDs for all materialized relationships to prevent duplication during incremental updates (if implemented).
