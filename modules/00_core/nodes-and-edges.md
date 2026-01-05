# IDEA Core: Node and Edge Specifications

This document defines the formal structure of the graph.

**Important notes on performance:** 
This documentation deals exclusively with the basic structure, not with possible performance optimization, as would be necessary for production. See [performance and scaling](../../docs/02_performance-and-scaling.md) and [roadmap](../../roadmap.md) for more information.

**Important notes on fixtures:** 
* For better readability, we use string-based IDs in the fixtures. In production, we would use INTs, as we aim to use an SQL database as our sSoT.
* The `scope` property of `IDENTIFIED_AS_CONCEPT` is not used in the fixtures.

## General Conventions

* **Labels:** PascalCase (e.g., `CompositionEntity`).
* **Properties:** lower_snake_case (e.g., `reasoning_statement`).
* **Edges:** UPPER_SNAKE_CASE (e.g., `IDENTIFIED_AS_CONCEPT`).
* **Directionality:** Fixed from the specific/concrete to the abstract/conceptual.
* **Uniqueness:** All properties ending in `_id` are enforced as unique constraints.


## 1. Physical Layer (Object Level)

### Node: `Unit`

**Description:** Represents the physical/virtual object/carrier.
**Labels:** `Unit`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `unit_id` | INT | Yes | Unique identifier for the physical/virtual object/carrier. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_COMPOSITION` | `Composition` | N:M | Links the physical/virtual object/carrier its visual containers/compositions. |

**Note:** Compositions can be linked to multiple units (if the units are definitely identical, serially produced).


## 2. Formal Analysis Layer (Description Level)

### Node: `Composition`

**Description:** A visual container of a unit containing all formal elements.
**Labels:** `Composition`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_id` | INT | Yes | Unique identifier for the composition. |
| `chromaticity` | ENUM | No | Color properties (e.g., "Polychromatic", "Monochromatic"). |

**Note:** We consider modelling chromaticity as a separate node. See [know issues](../../known-issues.md).

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_COMPOSITION_ENTITY` | `CompositionEntity` | 1:N | Identifies a distinct entity in the image. |
| `HAS_COMPOSITION_CONTEXT` | `CompositionContext` | 1:N | Links to the publication or historical context/meaning. |
| `HAS_COMPOSITION_GROUP` | `CompositionGroup` | 1:N | Logical grouping of elements. |
| `HAS_PATTERN` | `CompositionPattern` | 1:N | Reified link to an iconographical pattern. |
| `HAS_COMPOSITION_COMPARISON` | `CompositionComparison` | 1:N | Links to a comparative analysis with other compositions. |


### Node: `CompositionEntity`

**Description:** A neutral, formal element identified in the composition (e.g., a figure, an object, decoration).
**Labels:** `CompositionEntity`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_entity_id` | INT | Yes | Unique identifier for the formal entity. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_COMPOSITION_FEATURE` | `CompositionFeature` | 1:N | Assigns an attribute or state to this entity. |
| `HAS_COMPOSITION_RELATION` | `CompositionRelation` | 1:N | Starts a directed action/relation from this entity. |
| `IS_PART_OF_COMPOSITION_GROUP` | `CompositionGroup` | N:M | (Optional) Assigns the entity to a group/container. |
| `HAS_INTERPRETATION` | `Interpretation` | 1:N | Links to the epistemic identification of the entity. |


### Node: `CompositionFeature`

**Description:** A formal attribute or temporary state belonging to a `CompositionEntity`.
**Labels:** `CompositionFeature`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_feature_id` | INT | Yes | Unique identifier for the feature. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_INTERPRETATION` | `Interpretation` | 1:N | Links to the epistemic identification of the feature. |


### Node: `CompositionRelation`

**Description:** An atomic action or relationship between two entities.
**Labels:** `CompositionRelation`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_relation_id` | INT | Yes | Unique identifier for the relation. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_COMPOSITION_RELATION_OBJECT` | `CompositionEntity` | N:1 | Defines the target entity (object) of the relation. |
| `HAS_COMPOSITION_MODIFIER` | `CompositionModifier` | 1:N | Adds specific details (e.g., handedness) to the relation. |
| `HAS_COMPOSITION_EVENT` | `CompositionEvent` | 1:N | Groups the atomic relation into a macro-event. |
| `HAS_INTERPRETATION` | `Interpretation` | 1:N | Links to the epistemic identification of the action. |


### Node: `CompositionModifier`

**Description:** Describes the specific execution of a `CompositionRelation`.
**Labels:** `CompositionModifier`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_modifier_id` | INT | Yes | Unique identifier for the modifier. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_INTERPRETATION` | `Interpretation` | 1:N | Links to the epistemic identification of the modifier. |


### Node: `CompositionEvent`

**Description:** Represents a macro-level action consisting of (multiple) relations.
**Labels:** `CompositionEvent`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_event_id` | INT | Yes | Unique identifier for the event. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_INTERPRETATION` | `Interpretation` | 1:N | Links to the epistemic identification of the event. |


### Node: `CompositionGroup`

**Description:** A logical container or spatial region within a composition.
**Labels:** `CompositionGroup`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `composition_group_id` | INT | Yes | Unique identifier for the group. |
| `group_function` | ENUM | No | Purpose of the group (e.g., "LogicalUnit", "TextContainer"). |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_READING` | `Reading` | 1:N | Links to the epistemic interpretation of text in this group. |


## 3. Epistemic Layer (Interpretation Level)

### Node: `Interpretation`

**Description:** The central node for semantic assignment and uncertainty modeling.
**Labels:** `Interpretation` (Sub-labels: `EntityInterpretation`, `FeatureInterpretation`, `RelationInterpretation`, `ModifierInterpretation`, `EventInterpretation`, `ContextInterpretation`)

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `interpretation_id` | INT | Yes | Unique identifier for the interpretation. |
| `certainty` | FLOAT | No | Confidence value (0.0 to 1.0). |
| `status` | ENUM | No | Assignment status: "Primary", "Alternative", "Rejected", "Outdated". |
| `reasoning_statement` | TEXT | No | Expert justification for this specific interpretation. |
| `timestamp` | STRING | No | Date of the interpretation. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `IDENTIFIED_AS_CONCEPT` | `Concept` | 1:N | Semantic link to ThING. Requires `scope` if N > 1. |
| `STATED_BY` | `Agent` | N:1 | The Agent who created the interpretation. |
| `REJECTED_BY` / `ACCEPTED_BY` | `Agent` | N:M | Validation by one or more agents. |
| `SUPPORTED_BY` | `Architectonic` | N:M | Methodological grounding (e.g., logical deduction). |
| `IMPAIRED_BY` | `Architectonic` | N:M | Weakening factors (e.g., ambiguity). |
| `HAS_SOURCE_REFERENCE` | `SourceReference` | 1:N | Links to external evidence (reference images, literature). |
| `RECOGNIZED_PATTERN` | `Pattern` | N:1 | Links an interpretation to a generic Pattern definition (only for CompositionsPatterns). |
| `DEPENDS_ON` | `Interpretation` | 1:N | Logical dependency on another interpretation. |

**Edge Properties for `IDENTIFIED_AS_CONCEPT`:**
(if N > 1)

* `scope`: ENUM ("VisualAppearance", "ActualMeaning", "FunctionalMeaning")

**Edge Properties for `ACCEPTED_BY` / `REJECTED_BY`:**
(if Interpretation timestamp and Edge timestamp are not equal)

* `timestamp`: STRING (if different from interpretation timestamp)


### Node: `Reading`

**Description:** The interpretation of signs/letters.
**Labels:** `Reading`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `reading_id` | INT | Yes | Unique identifier. |
| `read_string` | STRING | No | The transcribed content. |
| `certainty` | FLOAT | No | Confidence in the reading. |
| `lang` | STRING | No | Language code (e.g., "EN", "LAT"). |
| `status` | ENUM | No | "Primary", "Alternative", "Rejected", "oOtdated". |
| `timestamp` | STRING | No | Date of entry. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `STATED_BY` | `Agent` | N:1 | The Agent who created the interpretation. |
| `REJECTED_BY` / `ACCEPTED_BY` | `Agent` | N:M | Validation by one or more agents. |
| `IMPAIRED_BY` | `Architectonic` | N:M | Factors like wear or fragmentation. |


### Node: `SourceReference`

**Description:** A specific evidentiary statement linking an interpretation to a source.
**Labels:** `SourceReference`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `source_reference_id` | INT | Yes | Unique identifier. |
| `reference` | STRING | No | Specific locator (e.g., page number, image-ID). |
| `refrence_statement` | TEXT | No | Description of the evidence found in the source. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_SOURCE` | `Source` | N:1 | Links to the container source. |
| `HAS_EVIDENTIARY_RELATIONSHIP`| `Architectonic`| N:1 | Nature of evidence (e.g., "concurring", "conflicting"). |


## 4. Ontological Layer (ThING & Patterns)

### Node: `Concept`

**Description:** Semantic lemma in the Tree of Concepts.
**Labels:** `Concept` (Sub-labels: `Entity`, `Feature`, `Relation`, `Modifier`, `Event`, `Context`)

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `concept_id` | INT | Yes | Semantic URI or ID. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `IS_A` | `Concept` | N:M | Hierarchical parent-child relationship (Strictly Acyclic). |


### Node: `Pattern`

**Description:** Abstract iconographical pattern defining a scene structure.
**Labels:** `Pattern`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `pattern_id` | INT | Yes | Unique identifier for the pattern. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_PATTERN_ENTITY` | `PatternEntity` | 1:N | Defines an abstract actor in the pattern. |


### Node: `PatternEntity`

**Description:** Abstract placeholder for an entity within a pattern.
**Labels:** `PatternEntity`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `pattern_entity_id` | INT | Yes | Unique identifier. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_CONCEPT` | `Concept` | N:M | The required semantic type for this actor. |
| `HAS_PATTERN_RELATION` | `PatternRelation` | 1:N | Defines actions expected from this actor in the pattern. |

**Edge Properties for `HAS_CONCEPT`:**
(if N > 1)

* `scope`: ENUM ("VisualAppearance", "ActualMeaning", "FunctionalMeaning")


### Node: `PatternRelation`

**Description:** Abstract placeholder for an action within a pattern.
**Labels:** `PatternRelation`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `pattern_relation_id` | INT | Yes | Unique identifier. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `HAS_CONCEPT` | `Concept` | N:M | The required semantic type for the action. |
| `HAS_PATTERN_RELATION_OBJECT`| `PatternEntity` | N:1 | The abstract target of the action. |

**Edge Properties for `HAS_CONCEPT`:**
(if N > 1)

* `scope`: ENUM ("VisualAppearance", "ActualMeaning", "FunctionalMeaning")


### Node: `Architectonic`

**Description:** Meta-concepts for methodology and epistemic classification.
**Labels:** `Architectonic` (Sub-label: `Methodology`)

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `architectonic_id` | INT | Yes | Unique identifier. |

**Outgoing Edges:**
| Type | Target Node | Cardinality | Description |
| :--- | :--- | :--- | :--- |
| `IS_A` | `Architectonic` | N:M | Hierarchical relationship (Strictly Acyclic). |


### Node: `Agent`

**Description:** Entities (Human or AI) responsible for statements and validations.
**Labels:** `Agent` (Sub-labels: `HumanAgent`, `AIAgent`)

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `agent_id` | INT | Yes | Unique identifier for the agent. |


### Node: `Source`

**Description:** Bibliographic or archival container (e.g., a book or database).
**Labels:** `Source`

| Property | Type | Unique | Description |
| --- | --- | --- | --- |
| `source_id` | INT | Yes | Unique identifier. |
