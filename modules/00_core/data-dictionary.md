# IDEA Core: Data Dictionary

This document defines the allowed values, data types, and constraints for properties within the IDEA Core. It ensures data integrity across the Relational Database (Source of Truth) and the Graph DB (Query Layer).

## 1. Global Value Constraints

These constraints apply to all nodes and edges where these property names are used.

| Property | Type | Range / Format | Description |
| --- | --- | --- | --- |
| `certainty` | FLOAT |  | Confidence level of an interpretation or reading. |
| `timestamp` | STRING | ISO 8601 (YYYY-MM-DD) | Date of creation or validation. |
| `lang` | STRING | ISO 639-1 / 639-3 | Language code (e.g., "EN", "LAT", "GRC"). |

---

## 2. Core Enumerations (ENUMs)

The following values are the current defaults for the IDEA Core. These lists are non-exhaustive and will be expanded by future updates.

### 2.1 Composition Enums

#### `chromaticity`

Used in the `Composition` node to describe visual color properties.

* **`Polychromatic`**: Multi-colored appearance.
* **`Monochromatic`**: Single color or grayscale appearance.

**Note:** We consider using a separate node instead of a property

### 2.2 Structural Enums

#### `group_function`

Used in `CompositionGroup` to define the logical or spatial purpose of a container.

* **`LogicalUnit`**: A functional grouping of entities.
* **`TextContainer`**: A region specifically designated for inscriptions or signs.

### 2.3 Epistemic Enums

#### `status`

Used in `Interpretation` and `Reading` to define the weight of a statement.

* **`Primary`**: The currently favored or most widely accepted interpretation.
* **`Alternative`**: A valid but secondary interpretation.
* **`Rejected`**: An interpretation that has been explicitly dismissed by an agent.

#### `scope`

Used in the `IDENTIFIED_AS_CONCEPT` and `HAS_CONCEPT` edges. It qualifies the nature of the link between a formal element and a semantic concept.
The `scope` poperty is set if the cardinality is  N > 1.

* **`VisualAppearance`**: Relates to what the element looks like.
* **`ActualMeaning`**: Relates to the specific identification.
* **`FunctionalMeaning`**: Relates to the role within the scene.

---

## 3. Ontological Structures

IDEA uses two distinct hierarchical systems (Strictly Acyclic Graphs).

### 3.1 Concept Taxonomy (ThING)

* **Labels**: `Concept` (Sub-labels: `Entity`, `Feature`, `Relation`, `Modifier`, `Event`, `Context`).
* **Property**: `concept_id` (INT, Unique).
* **Hierarchy**: Defined by `IS_A` edges.

### 3.2 Architectonic Meta-Ontology

* **Labels**: `Architectonic` (Sub-label: `Methodology`).
* **Property**: `architectonic_id` (INT, Unique).
* **Hierarchy**: Defined by `IS_A` edges.
* **Purpose**: Meta-concepts for methodology and epistemic classification.

---

## 4. Technical Constraints

* **IDs**: All properties ending in `_id` must be stored as `INT` (SQL) and enforced as `UNIQUE` constraints in Neo4j (Fixtures use slugs for better UX).
* **Strings**: All `TEXT` fields use UTF-8 encoding to support Greek and other non-Latin scripts.