# IDEA: Example Queries

This document provides example Cypher queries to demonstrate the investigative potential of the **IDEA** framework. These queries are designed to run against the **baseline structure** (as defined in `99_fixtures.cypher`), utilizing standard graph traversals without performance-optimized materialized paths.

## 1. Ontology Overview (Recursive Hierarchy)

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

---

## 2. Semantic Context: "Human holding Fruit"

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

---

## 3. High-Certainty Fact Extraction

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

---

## 4. Human-in-the-Loop: Rejected Interpretations

**Scenario:** Identify entity interpretations that were proposed (e.g., by an AI) but explicitly rejected by a human expert. This is essential for identifying AI bias or outdated scholarly opinions

```cypher
MATCH (ce:CompositionEntity)-[:HAS_INTERPRETATION]->(i:Interpretation)
MATCH (i)-[:REJECTED_BY]->(a:HumanAgent)
MATCH (i)-[:IDENTIFIED_AS_CONCEPT]->(con:Concept)
RETURN ce.composition_entity_id, con.concept_id, i.reasoning_statement
```

**Expected Output:**
* entity-bb-glyph, concept-letter-l, "Commen Scheme, but ambiguous"

---

## 5. Conflict Analysis: Interpretations vs. Sources

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

---

## 6. Pattern-Based Rapid Access

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

