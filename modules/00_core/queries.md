# IN.IDEA: Example Queries

This document provides example Cypher queries to demonstrate the investigative potential of the **IN.IDEA** framework. These queries are designed to run against the **IN.IDEA Core** (as defined in `99_fixtures.cypher`). Performance optimization is not applied, except for `concept_path_ids` on `Concept` nodes as **Materialized Path Arrays**.


## 1. Look for identified Concepts in Units:

**Scenario:** Show all units with entities identified as "Object" and the certainty of identification.

### Traditional approch:

This approach navigates the physical layers and then performs a recursive search up the taxonomic tree to identify objects.

```cypher
MATCH (u:Unit)-[:HAS_COMPOSITION]->(:Composition)-[:HAS_COMPOSITION_ENTITY]->(ce:CompositionEntity)
MATCH (ce)-[:HAS_INTERPRETATION]->(i:Interpretation)-[:IDENTIFIED_AS_CONCEPT]->(baseConcept:Concept)
MATCH (baseConcept)-[:IS_A*0..]->(target:Concept {concept_id: 'concept-object'})
RETURN 
    u.unit_id AS Unit, 
    ce.composition_entity_id AS CompositionEntity, 
    i.certainty AS IdentificationCertainty, 
    baseConcept.concept_id AS IdentifiedConcept;
```

**Expected Output:**
* unit-apple-tomato, entity-at-apple-tomato, 0.5, concept-tomato
* unit-apple-tomato, entity-at-apple-tomato, 0.4, concept-apple
* unit-billiard-ball, entity-bb-billiard-ball-sphere, 1.0, concept-billiard-ball-7

> [!NOTE]
> **Performance:** The critical bottleneck is the `IS_A`-relation. This forces the database to perform a live, recursive search through the ontology for every potential result. While functional for small fixtures, this  operation scales poorly; as the taxonomy grows deeper, query latency increases linearly with each additional level in the hierarchy.

### Optimized Query (Materialized Path)

This approach leverages the **Hierarchical Flattening** strategy by checking a pre-calculated array of all ancestors stored on each concept node.

```cypher
MATCH (c:Concept)
WHERE 'concept-object' IN c.concept_path_ids
MATCH (c)<-[:IDENTIFIED_AS_CONCEPT]-(i:Interpretation)
MATCH (i)<-[:HAS_INTERPRETATION]-(ce:CompositionEntity)
MATCH (ce)<-[:HAS_COMPOSITION_ENTITY]-(comp:Composition)<-[:HAS_COMPOSITION]-(u:Unit)
RETURN 
    u.unit_id AS Unit, 
    ce.composition_entity_id AS CompositionEntity, 
    i.certainty AS IdentificationCertainty, 
    c.concept_id AS IdentifiedConcept;

```

**Expected Output:**
* unit-apple-tomato, entity-at-apple-tomato, 0.5, concept-tomato
* unit-apple-tomato, entity-at-apple-tomato, 0.4, concept-apple
* unit-billiard-ball, entity-bb-billiard-ball-sphere, 1.0, concept-billiard-ball-7

> [!NOTE]
> **Performance:** The recursive expander has been replaced by a local **Filter**. This constitutes an ** hierarchy lookup**; the cost to verify if a concept is an "object" is now constant and independent of the taxonomy's depth.


## 2. Ontology Overview (Recursive Hierarchy)

**Scenario:** Show all concepts descending from concept-object as paths.

```cypher
MATCH path = (child:Concept)-[:IS_A*]->(parent:Concept {concept_id: 'concept-object'})
RETURN path
```
**Expected Output:**
* (:Concept:Fixture:Entity {concept_id: "concept-sports-equipment"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-object"})
* (:Concept:Fixture:Entity {concept_id: "concept-billiard-ball"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-sports-equipment"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-object"})
* (:Concept:Fixture:Entity {concept_id: "concept-billiard-ball-7"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-billiard-ball"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-sports-equipment"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-object"})
* (:Concept:Fixture:Entity {concept_id: "concept-fruit"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-object"})
* (:Concept:Fixture:Entity {concept_id: "concept-apple"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-fruit"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-object"})
* (:Concept:Fixture:Entity {concept_id: "concept-tomato"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-fruit"})-[:IS_A]->(:Concept:Fixture:Entity {concept_id: "concept-object"})

**NOTE:**
These nodes represent the strictly acyclic hierarchy of the model. Concept related metadata can be added via ontology module.
They can be further enriched with domain-specific modules (e.g., Numismatics) to provide detailed descriptions of ancient iconography.


## 3. Semantic Context: "Human holding Fruit"

**Scenario:** Find compositions where a human (Entity) is holding (Relation) as fruit (Entity), not just keywords.

```cypher
MATCH (u:Unit)-[:HAS_COMPOSITION]->(comp:Composition)

MATCH (comp)-[:HAS_COMPOSITION_ENTITY]->(ce_human:CompositionEntity)
MATCH (ce_human)-[:HAS_INTERPRETATION]->(:Interpretation)-[:IDENTIFIED_AS_CONCEPT]->(:Concept {concept_id: 'concept-human'})

MATCH (ce_human)-[:HAS_COMPOSITION_RELATION]->(rel:CompositionRelation)
MATCH (rel)-[:HAS_INTERPRETATION]->(:Interpretation)-[:IDENTIFIED_AS_CONCEPT]->(:Concept {concept_id: 'concept-holding'})

MATCH (rel)-[:HAS_COMPOSITION_RELATION_OBJECT]->(ce_fruit:CompositionEntity)
MATCH (ce_fruit)-[:HAS_INTERPRETATION]->(:Interpretation)-[:IDENTIFIED_AS_CONCEPT]->(c_fruit:Concept)
MATCH (c_fruit)-[:IS_A*0..]->(:Concept {concept_id: 'concept-fruit'})

RETURN DISTINCT comp.composition_id
```
**Expected Output:**
* composition-apple-tomato


## 4. High-Certainty Fact Extraction

**Scenario:** Retrieve only the "Gold Standard" identifications of entities where the certainty is high and the status is primary.

```cypher
MATCH (u:Unit)-[:HAS_COMPOSITION]->(c:Composition)
MATCH (c)-[:HAS_COMPOSITION_ENTITY]->(ce:CompositionEntity)
MATCH (ce)-[:HAS_INTERPRETATION]->(i:Interpretation)
MATCH (i)-[:IDENTIFIED_AS_CONCEPT]->(con:Concept)
WHERE i.status = 'Primary' 
  AND i.certainty > 0.8
RETURN ce.composition_entity_id, con.concept_id, i.certainty
```

**Expected Output:**
* entity-at-human, concept-human, 1.0
* entity-bb-billiard-ball-sphere, concept-billiard-ball-7, 1.0


## 5. Human-in-the-Loop: Rejected Interpretations

**Scenario:** Identify entity interpretations that were proposed (e.g., by an AI) but explicitly rejected by a human expert. This is essential for identifying AI bias or outdated scholarly opinions

```cypher
MATCH (ce:CompositionEntity)-[:HAS_INTERPRETATION]->(i:Interpretation)
MATCH (i)-[:REJECTED_BY]->(a:HumanAgent)
MATCH (i)-[:IDENTIFIED_AS_CONCEPT]->(con:Concept)
RETURN ce.composition_entity_id, con.concept_id, i.reasoning_statement
```

**Expected Output:**
* entity-bb-glyph, concept-letter-l, "Commen Scheme, but ambiguous"


## 6. Conflict Analysis: Interpretations vs. Sources

**Scenario:** Find cases where an expert's interpretation is in direct conflict with the cited reference material. This is important to understand the low certainty or to check the references.

```cypher
MATCH (i:Interpretation)-[:HAS_SOURCE_REFERENCE]->(sr:SourceReference)
MATCH (sr)-[:HAS_EVIDENTIARY_RELATIONSHIP]->(arch:Architectonic {architectonic_id: 'architectonic-conflicting'})
MATCH (sr)-[:HAS_SOURCE]->(s:Source)
MATCH (i)-[:STATED_BY]->(agent:Agent)
RETURN i.interpretation_id, agent.agent_id, sr.reference, sr.refrence_statement, s.source_id
```
**Expected Output:**
* interpretation-at-apple, agent-human, img-at-apple-conflicting, "apple reference image shows stem", source-at-reference-catalogue


## 7. Pattern-Based Rapid Access

**Scenario:** Quickly identify all Compositions that match a standardized iconographical scene, such as "Human holding object". This is faster than going into the formal analysis.

```cypher
MATCH (u:Unit)-[:HAS_COMPOSITION]->(c:Composition)
MATCH (c)-[:HAS_PATTERN]->(cp:CompositionPattern)
MATCH (cp)-[:HAS_RECOGNITION]->(i:Interpretation)
MATCH (i)-[:RECOGNIZED_PATTERN]->(p:Pattern {pattern_id: 'pattern-human-holding-object'})
RETURN u.unit_id, c.composition_id, i.certainty
```

**Expected Output:**
* unit-apple-tomato, composition-apple-tomato, 1.0
* unit-billiard-ball, composition-billiard-ball, 1.0

