# How to Annotate with IDEA

This guide walks you through the process of describing a visual scene using the IDEA framework. To illustrate the workflow, we will use the **"Apple-Tomato"** example: a composition where a human hand holds a red object that could be either an apple or a tomato.

Instead of just "tagging" an image, we build a path from the **concrete observation** to the **abstract concept**, documenting every step of the interpretive process.

We recommand having the following files at hand:
* [architecture.md](01_architecture.md)
* [nodes-and-edges.md](../modules/00_core/nodes-and-edges.md)
* [fixtures.md](../modules/00_core/fixtures.md)

---

## The Workflow: Vertical Stacking

For every element you identify, you complete the path from Layer II (Formal) to Layer IV (Ontological) before moving to the next element.

> **Note on Methodology:** While CV models typically use a **horizontal stack approach** (processing all entities, then all features, then all relations across the entire composition to maximize computational efficiency), we recommend the **vertical stack approach** for human annotators. This is often more accessible to the human mind as it maintains the semantic context of a single visual element — from observation to interpretation — before moving to the next part of the image.


### Step 0: Define the Frame (Layer I & II)

Before describing content, establish the `Unit` and the visual container (`Composition`).

> **Note on Units:** When dealing only with virtual resources, the unit may seem redundant at first glance, but it is indispensable when handling real-world objects such as, in our case, ancient coins, as we have a physical carrier and multiple image zones (compositions).

* **Unit**: The physical/virtual object (e.g., `unit-apple-tomato`).
* **Composition**: The specific view or side being analyzed (e.g., `composition-apple-tomato`).

---

### Step 1: Identify an Entity (The "Apple-Tomato")

Now, we describe the red object held in the hand.

#### 1.1 The Formal Observation (Layer II)

Create a `CompositionEntity`. At this stage, do not call it an "apple"; it is simply a "thing" in the image.

* **Node**: `(entity-at-apple-tomato:CompositionEntity)`


#### 1.2 The Interpretive Act (Layer III)

This is the "Epistemic Primary" step. Since the object is ambiguous, we create **two** interpretations for the same entity.

* **Interpretation A**: Likely a tomato.
  * `certainty: 0.5`, `reasoning_statement: "Tomato texture, uncommon shape"` 
* **Interpretation B**: Possibly an apple.
  * `certainty: 0.4`, `reasoning_statement: "Apple shape, but no stem"` 


#### 1.3 Linking to Concepts (Layer IV)

Connect each interpretation to the global `Concept` tree (ThING).

* `Interpretation A` --IDENTIFIED_AS_CONCEPT--> `concept-tomato` 
* `Interpretation B` --IDENTIFIED_AS_CONCEPT--> `concept-apple` 

---

### Step 2: Describe Features

Entities have attributes. Let's describe the color of our object.

#### 2.1 Formal Feature (Layer II)

* **Node**: `(feature-at-apple-color:CompositionFeature)`
* **Edge**: `entity-at-apple-tomato` --HAS_COMPOSITION_FEATURE--> `feature-at-apple-color`

> **Feature vs. Relation**: Features are Attributes/states of an entity. While `standing` is a state, `standing_on` is directed and requires an object (another entity). `standing_on` should therefore be modeled as a `Relation`. In many cases it es a good idea to model both (`standing` as `Feature` and `standing_` as `Relation`) since it makes queries easier.


#### 2.2 Interpretation & Concept (Layer III & IV)

* **Interpretation**: Certainty 1.0 (it is definitely red).
* **Concept**: `concept-red` 

---

### Step 3: Map Relations and Actions

An image is rarely static. In our example, a human is holding the object.

#### 3.1 The Relation (Layer II)

Define the action between the human (`entity-at-human`) and the object.

* **Node**: `(relation-at-holding:CompositionRelation)`
* **Edges**:
  * `entity-at-human` --HAS_COMPOSITION_RELATION--> `relation-at-holding` 
  * `relation-at-holding` --HAS_COMPOSITION_RELATION_OBJECT--> `entity-at-apple-tomato` 

> **Relation vs. Event**: A Relation is the atomic link between two distinct entities. For relations between 3 or more entities, use `Event` nodes: `Relation` --HAS_COMPOSITION_EVENT--> `Event`


#### 3.2 Adding Modifiers

Was it the right or left hand?

* **Modifier**: `modifier-at-using-right-hand` 
* **Interpretation**: "Arrangement of fingers indicates the right hand." 
* **Concept**: `concept-using-right-hand` 

---

### Step 4: Handling "The Hand" and Cropping (Visual Scope)

A common pitfall is to declare the hand as its own `Entity`. In IDEA, we usually treat the **Human** as the entity, while the **Hand** and the fact that it is a **Detail** (cropped) are handled as `Features`.

#### 4.1 Why not "Entity: Hand"?

If we labeled the hand as an entity, we would lose the connection to the person. Instead, we identify the person as the entity and describe the "hand-ness" and the "cropping" as attributes of how that person is depicted.


#### 4.2 Formal Feature: Visual Scope (Layer II)

We observe that only a part of the human is visible.

* **Node**: `(feature-at-human-visual-scope:CompositionFeature)` 
* **Edge**: `entity-at-human` --HAS_COMPOSITION_FEATURE--> `feature-at-human-visual-scope` 


#### 4.3 Interpretation: The Cropping (Layer III)

We document *why* we think this is a detail.

* **Interpretation**: `interpretation-at-human-visual-scope` 
  * **Reasoning**: "Obvious cropping of the subject at the right edge of the frame." 
  * **Certainty**: `1.0` (it is a factual observation of the frame) 


#### 4.4 Ontological Mapping: Visual Scope (Layer IV)

Finally, we link this to the ThING to enable queries like "Show me all human details".

* **Primary Concept**: `concept-detail-hand` 
* **Parent Concept**: `concept-human-visual-scope`  (which is a type of `concept-visual-scope`) 

> **Feature vs. Entity**: If it is a part of a larger being (like a hand, an eye, or a wing), model it as a **Feature** of that being. If it is a separate, moveable object (like a sword, a shield, or a tomato), model it as a separate **Entity**.

---

### Step 5: Justify with Methodology (Architectonics)

To make your uncertainty transparent, link your interpretations to methodological "Architectonics."

* **Conflict**: If a reference image shows a stem but yours doesn't, use `architectonic-conflicting`. 
* **Ambiguity**: If the shape is unclear, mark the interpretation as --`IMPAIRED_BY`--> `architectonic-ambiguity`. 

---

### Step 6: Abstract Meanings (CompositionContext)

Sometimes, a composition refers to something that isn't a physical "thing" in the image, such as a historical event, a specific myth, or a publication context.

* **The Problem**: You cannot point to a "Battle of Actium" node in the visual pixels, but the image is clearly about it.
* **The Solution**: Use a `CompositionContext` node.
* **Workflow**:
  1. **Formal**: Create a `CompositionContext` and link it to your `Composition`.
  2. **Epistemic**: Add an `Interpretation` (e.g., certainty 1.0, reasoning: "Defined by publication context").
  3. **Ontological**: Link to the abstract concept (e.g., `concept-functional-demo` or a historical event concept).

---

### Step 7: Dealing with Text (Reading & Groups)

To handle text (like the "7" on a billiard ball), IDEA uses a specific structure that separates the logical container from the actual signs.

1. **Create a Container**: Create a `CompositionGroup` with the `group_function: "TextContainer"` and link it to the `Composition`.
2. **Optional Glyphs**: If you want to be precise, create `CompositionEntity` nodes for individual letters/signs and link them to the group using `IS_PART_OF_COMPOSITION_GROUP`.
3. **The Reading**: Instead of a standard `Interpretation`, link a `Reading` node to the `CompositionGroup`.
  * **Properties**: In addition to `certainty`, a `Reading` includes `read_string` (the transcribed text) and `lang` (the language, e.g., "EN").
  * **Logic**: Just like interpretations, readings can be `STATED_BY` an agent or `IMPAIRED_BY` ambiguity (e.g., due to wear on a coin).

---

### Summary of the Path

When you are finished, a single "observation" (the red object) looks like this in the graph:

`Composition` → `CompositionEntity` → `Interpretation` → `Concept`

> **Note**: This path might seem longer than a simple tag, but it allows IDEA to answer complex questions like: *"Show me all objects where the identification as 'Apple' was disputed due to 'Ambiguity'."*

---

### Important: Why no Graphical Annotations (Polygons)?

You might notice that there are no properties for coordinates or polygons (e.g., SVG/JSON) in the graph nodes. This is a deliberate design choice for **performance and efficiency**.

* **Separation of Concerns**: IDEA follows a strict "Read-Optimized Projection" philosophy.
* **Spatial Performance**: Complex spatial queries (e.g., "Is entity A inside the region of group B?") are handled much more efficiently in a relational database like **PostgreSQL** using spatial extensions.
* **The Link**: We store the graphical coordinates (polygons) in the relational Single Source of Truth (SSoT). These are mapped to the unique `_id` of the `CompositionEntity` or `CompositionGroup`.
* **The Result**: The graph stays lean and fast for semantic traversals, while the frontend fetches the visual coordinates from the SQL backend when it needs to draw them on the screen.

---

## Additional Structures:

### Using Patterns as Blueprints

When a scene follows a common iconographical scheme (e.g., "Human holding an object"), you don't have to reinvent the wheel every time. IDEA uses **Patterns** as reusable blueprints.

* **Simplified Structure**: Unlike a full analysis, a `Pattern` uses a reduced set of nodes: only `PatternEntity` and `PatternRelation`.
* **No Epistemic Layer inside Patterns**: Because patterns are abstract and "idle," they don't need interpretation nodes or certainty values within their own structure; they link directly to `Concepts`.
* **Linking to Reality**: To apply a pattern to a real image, you create an `Interpretation` node between the `Composition` (or `CompositionPattern`) and the `Pattern`.
* **Benefit**: This "epistemic shift" makes patterns much faster to create and act as a filter for thousands of similar images.

### Patterns as a "Scaffold" for AI Annotation

Patterns serve a critical role in automated workflows, especially when dealing with ambiguous or damaged material where a specific scene cannot be identified with certainty.

* **Contextual Grounding**: Even if an AI agent cannot recognize a specific mythological or historical scene, a Pattern provides the necessary **structural scaffold**.
* **Iconographical "Priors"**: Patterns act as visual archetypes (e.g., "Enthroned figure with scepter"). If the AI identifies a "Figure" and a "Scepter," the Pattern suggests the most probable relational structure, even if the specific identity of the deity remains unknown.
* **Error Reduction**: By forcing the AI to align its findings with predefined `PatternEntity` and `PatternRelation` structures, we reduce the risk of "hallucinated" relations that do not exist in the iconographical record.
* **Human-in-the-Loop**: The AI proposes a `PatternRecognition` based on these blueprints, which a human expert can then easily validate or refine by setting the `certainty` value in the Interpretation layer.

---

### Modeling Similarity (The Centroid Approach)

If two or more compositions look alike, IDEA avoids creating direct "looks-like" edges between every single image. Instead, we use a **Centroid Model** to handle clusters of similarity.

1. **The Hub**: A `CompositionParallel` node acts as the center (centroid) of a similarity cluster.
2. **The Spokes**: Each `Composition` is linked to this hub via a `CompositionComparison` node.
3. **Aggregated Data**: The hub stores the collective data of the cluster, such as the `similarity_average` and the `assertion_count`.
4. **Connecting Clusters**: For images that are only slightly similar, we do not create a new huge cluster. Instead, we create a single "bridge" between two representative compositions of different clusters.
5. **Human vs. AI**: While humans often prefer 1:1 comparisons, this centroid approach is specifically designed for **AI agents**. AI can efficiently calculate these clusters based on feature vectors, making the graph a perfect training set for machine learning.

