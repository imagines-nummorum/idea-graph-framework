# IDEA Fixtures: Sandbox Documentation

This document describes the test datasets (fixtures) provided in the IDEA Core Docker container. These examples are designed to demonstrate the framework's ability to model **epistemic uncertainty**, **multimodal interpretations**, and **complex scene structures**. If you want to know more about the annotation process, see [how-to-annotate-using-idea](../../docs/03_how-to-annotate-using-idea.md).

## 1. Documentation Assets 

To understand the structural logic of IDEA, we provide both static visual examples and interactive model diagrams.

![Fixture-Images showing two compositions: a hand holding an apple-tomato and a hand holding a billiard-ball](assets/core-fixture-compositions-merged.jpg)
Figure 1: Visual representation of the composition-apple-tomato and composition-billiard-ball test cases.

The provided Neo4j Docker setup loads the fixtures directly into the database during startup. Alternatively, you can also find SVGs or JSON exports for [Arrows.app](https://arrows.app) here. 

* "Apple-Tomato" Analysis: [SVG](assets/apple-tomato_analysis.svg) | [JSON](assets/apple-tomato_analysis.json)
* "Apple-Tomato" Epistemic Layer: [SVG](assets/apple-tomato_epistemic-layer.svg) | [JSON](assets/apple-tomato_epistemic-layer.json)
* "Billiard Ball" Analysis: [SVG](assets/billiard-ball_analysis.svg) | [JSON](assets/billiard-ball_analysis.json)
* "Billiard Ball" Epistemic Layer: [SVG](assets/billiard-ball_epistemic-layer.svg) | [JSON](assets/billiard-ball_epistemic-layer.json)
* Patterns: [SVG](assets/patterns.svg) | [JSON](assets/patterns.json)
* Comparisons: [SVG](assets/comparisons.svg) | [JSON](assets/comparisons.json)

## 2. Design Principles of the Fixtures

* **Pedagogical Simplification:** The images are intentionally AI-generated and only partially annotated. We focus on specific challenges (ambiguity, OCR, AI-vs-Human perception) rather than exhaustive description.
* **Human-Readable IDs:** In this sandbox, we use string-based identifiers (e.g., `unit-apple-tomato`) for easier navigation in the Neo4j Browser. In production, these are mapped to `INT` keys.
* **Domain Agnosticism:** While IDEA is rooted in numismatics, these fixtures use everyday objects to ensure the architectural logic is understood by non-experts.


## 3. Case Study A: The "Apple-Tomato" (Epistemic Ambiguity)

This case demonstrates how IDEA handles material ambiguity where an object cannot be clearly assigned to a single concept.

### Data Model Highlights
* **Entity Ambiguity:** The object is interpreted as both an "Apple" and a "Tomato".
* **Certainty Scoring:** * `interpretation-at-tomato`: Certainty **0.5** (Primary).
  * `interpretation-at-apple`: Certainty **0.4** (Alternative).
* **Architectonic Linking:** Both interpretations are marked as `IMPAIRED_BY` the architectonic node `architectonic-ambiguity`.
* **Evidence:** The interpretations are supported by conflicting and concurring `SourceReference` nodes (simulating reference catalogues).


## 4. Case Study B: The "Billiard Ball" (AI vs. Human Perception)

This case illustrates the difference between a "bottom-up" AI analysis (geometric decomposition) and a "top-down" human analysis (semantic identification), as well as character ambiguity.

### Multi-Layer Interpretation

| Agent | Interpretation Target | Identified Concept | Certainty |
| --- | --- | --- | --- |
| **Human** | `entity-bb-billiard-ball-sphere` | `concept-billiard-ball-7` | 1.0 |
| **AI** | `entity-bb-billiard-ball-sphere` | `concept-sphere` | 0.8 |
| **AI** | `entity-bb-circle` | `concept-bb-circle` | 1.0 |

### Reading & OCR Ambiguity

The character on the ball is modeled via the `Reading` node.

* **`reading-bb-7`**: Status "Primary", accepted by the human agent.
* **`reading-bb-l`**: Status "Rejected", stated by the AI but explicitly rejected by the human agent.
* Both readings are linked to `architectonic-ambiguity`.


### 5. Modeling Logic: The "Human Holding Object" Pattern

IDEA distinguishes between what is *visible* and what is *represented* to maintain a clean ontological structure.

#### The Pars-pro-Toto Problem & Visual Scope

In both compositions, only a hand is visible. However, we do not model a standalone "Hand" entity. Instead:

* **Entity Identification:** We identify the entity as a **Human** (`concept-human`).
* **Feature Attribution:** We assign a `CompositionFeature` to the human: `feature-at-human-visual-scope`.
* **Visual Scope:** This is interpreted as `concept-detail-hand`, a child of `concept-human-visual-scope`.
* **Reasoning:** The `reasoning_statement` explains that the cropping at the frame edge implies a full human body.

#### Handedness as a Relation Modifier

The "Hand" appears a second time in the logic, but as a **Modifier** of the action:

* **Relation:** The human entity performs the relation `relation-at-holding`.
* **Modifier:** This relation is refined by the modifier `modifier-at-using-right-hand`.
* **Semantic Link:** The modifier is interpreted and linked to the concept `concept-using-right-hand`.
* **Hierarchy:** In the ThING, `concept-using-right-hand` is a specialization of `concept-using-hand`.

#### Pattern Recognition

Both cases manifest the abstract `pattern-human-holding-object`. This allows users to query for the general scene structure (Human → Holding → Object) regardless of specific attributes or the type of object held.


## 6. Summary of Architectonic Nodes

The fixtures include several `Architectonic` nodes that define the "Why" behind an interpretation:

* `logical-deduction`: Used for the "Presentation" event interpretation.
* `ambiguity`: Used for the apple-tomato and character readings.
* `compositional-parallel`: Used to link the two compositions via a `CompositionParallel` hub
