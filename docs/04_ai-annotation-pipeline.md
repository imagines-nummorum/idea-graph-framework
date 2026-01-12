# IN.IDEA: AI-Assisted Annotation Pipeline (Blueprint)

## 1. Executive Summary: Breaking the "Cold Start" Problem

The manual annotation of hundreds of thousands of cultural heritage objects using the **IN.IDEA Four-Layer Architecture** is a high-precision but resource-intensive task. To achieve critical mass data, we need an AI-assisted pipeline.

This pipeline is designed to solve the **Cold Start Problem**: transforming legacy text-based descriptions into structured graph data. By utilizing Large Language Models (LLMs) and Retrieval-Augmented Generation (RAG), we shift the expert's role from **data entry** to **data validation** (Human-in-the-loop).

> **Note:** This pipeline is currently a conceptual blueprint and is in the early stages of implementation.


## 2. Pipeline Architecture

### Phase 1: Ontological Grounding (ThING Integration)

The pipeline is anchored in the existing **Ontological Layer (Layer IV)**.

* **Input:** The matured ThING vocabulary, consisting of hierarchical concepts (as of now >1k distinct entities).
* **Process:** The LLM is provided with the project's onotology to ensure semantic precision.
* **Mechanism:** Semantic Anchoring ensures that the AI does not "guess" but maps identified entities directly to existing `concept_id` values.
* **Output:** A system-prompt-ready taxonomy that prevents "semantic drift" or the creation of redundant tags.

### Phase 2: Pattern Distillation (Mass Processing)

Before annotating individual units, we define the iconographical "vocabulary" using legacy data.

* **Input:** Legacy descriptions and metadata.
* **Process:** * **NER & Relation Extraction:** LLMs extract entities and actions from text.
* **Abstraction:** Identifying recurring motifs to create **Pattern** nodes.
* **Output:** A robust graph populated with "blueprints" of common scenes.

### Phase 3: Composition Drafting (Automated Mapping)

Using the distilled patterns, the system generates initial graph drafts for new objects.

* **Input:** Single-unit descriptions and metadata.
* **Process:** * **Pattern Matching:** The LLM identifies which existing `Pattern` matches the description.
* **Layer II Generation:** The system automatically instantiates `CompositionElement` nodes based on the matched pattern.
* **Output:** A "Silver Standard" graph without finalized certainty values.

### Phase 4: Expert-in-the-Loop (Epistemic Enrichment)

The crucial step where "data" becomes "scholarly knowledge."

* **Process:** Experts review the AI-generated drafts via the future IN.IDEA Web Frontend.
* **Action:**
  * Validate or reject the `Interpretation` Nodes (no deletion to get feedback for the AI).
  * create new `Interpretation` nodes and link Methodology/Sources for complex interpretations.
* **Output:** The **Gold Standard** dataset.

### Phase 5: Scaling via RAG & Vector DB

As the Gold Standard grows, the system becomes self-improving.

* **Process:** 
  1. Validated **[Text Description + Cypher Statement]** pairs are stored in a **Vector Database**.
  2. For new, un-annotated units, the system performs a similarity search.
  3. The LLM uses the most similar "Gold" examples as context (**Few-Shot RAG**) to generate high-quality Cypher drafts.
* **Impact:** Drastic reduction in manual correction time over the project's lifespan.


## 3. Technical Stack

| Component | Technology | Role |
| --- | --- | --- |
| **LLM Orchestration** | LangChain / LangGraph | Managing multi-step extraction and validation loops. |
| **Vector Database** | Milvus / Weaviate | Storing embeddings of legacy descriptions and Cypher snippets. |
| **Graph DB** | Neo4j | The queryable projection of the IN.IDEA model. |
| **Single Source of Truth** | PostgreSQL | Relational storage for all validated transactions. |
| **Validation UI** | Vue.js | Expert interface for the Human-in-the-loop phase. |


## 4. Why this Approach?

1. **Hallucination Control:** Grounding the LLM in Phase 1 (ThING) and Phase 2 (Patterns) prevents the AI from "inventing" iconographical concepts outside the defined ontology.
2. **Epistemic Transparency:** The AI proposes, but the human signs off on the `certainty`. The graph preserves the provenance via `Agent` nodes.
3. **Efficiency:** Moving from *Generation* to *Verification* increases annotation speed by an estimated factor of 5 to 10.
4. **Legacy Data Valorization:** It turns decades of unstructured text-based research into a machine-readable training set for future models.


## 5. Future Outlook: From Text-to-Graph to Image-to-Graph

While the current pipeline focuses on **Natural Language Processing (NLP)** to leverage existing legacy descriptions, the IN.IDEA architecture is inherently **medium-agnostic**. The long-term objective is a **hybrid analysis model** or a direct **Computer Vision (CV)** approach:

* **Direct Image Annotation:** Future iterations will utilize AI models to perform instance segmentation directly on coin images, identifying and labeling segments as `CompositionEntity` nodes.
* **Hybrid Multimodal Analysis:** By combining visual segment analysis with free-text descriptions, the system can cross-validate findings, further increasing the `certainty` of interpretations in the Epistemic Layer.
* **Training Data Acquisition:** We are currently seeking resources to segment a large-scale corpus of numismatic imagery. This will create the necessary ground-truth dataset to train custom models capable of recognizing highly stylized or worn ancient iconography.