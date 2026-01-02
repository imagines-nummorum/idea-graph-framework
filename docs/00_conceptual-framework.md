# Conceptual Framework

## 1. IDEA as a Research Catalyst

IDEA (Iconographical Definitional Epistemological Architecture) is the structural scaffolding for a larger scientific mission. Our primary goal is the development and dissemination of the **ThING** (Thesaurus Iconographicus Nummorum Graecorum) — a multidimensional, hierarchical ontology designed to categorize the vast visual heritage of the ancient world. To build, refine, and provide the ThING as a high-performance research tool, we require a framework capable of handling hundreds of thousands of datasets over a 25-year period (2025–2050).

---

## 2. Beyond the CIDOC CRM Bottleneck

While CIDOC CRM is the gold standard for cultural heritage documentation, its abstraction often results in a "performance tax" when dealing with mass data.

* **The Complexity Challenge:** Modeling hundreds of thousands of scenes with highly nested event-based structures makes real-time graph traversals and rapid data entry difficult for large-scale projects.
* **The IDEA Alternative:** We developed IDEA as a specialized tool for **Large-Scale Iconography**. By using a fixed-depth architecture and a strict projection from a relational SSoT (Single Source of Truth), we achieve the performance necessary for advanced queries while maintaining semantic precision.

---

## 3. The Performance-Rigor Trade-off

Ancient numismatics and archaeology operate at the intersection of mass data and individual expert interpretation. IDEA bridges this gap:

* **Efficiency:** The framework is optimized for a workflow where experts validate generated drafts (LLM-supported) rather than building every node from scratch.
* **Interdisciplinary Modularization:** IDEA is built on the principle of **Open Science and Reciprocity**. By strictly separating a domain-agnostic Core from specialized extensions, we facilitate the reuse of our framework across different disciplines. We invite other fields to adapt the Core for their specific needs while benefiting from IDEA’s logic for handling uncertainty and formal analysis.

---

## 4. The Epistemic Mandate: Modeling Uncertainty

The greatest challenge in digitizing historical images is the "illusion of certainty." Traditional databases often force a binary choice: either an object is , or it is not.

* **Honest Data:** IDEA treats uncertainty as a structural feature. Through the **Epistemic Layer**, we reify interpretation, allowing "maybe" to be as searchable as "is".
* **Quantification:** By assigning `certainty` values and linking them to reasoning statements and methodologies (`Architectonic`), we create a "transparent graph". This allows researchers to query for "all certain identifications" as easily as for "all controversial hypotheses."

---

## 5. Vision: A High-Resolution Dataset for the Future

By documenting not just the results, but the **process of interpretation**, IDEA generates a unique "extremity dataset." This corpus is designed to provide future AI training models with a nuanced understanding of ambiguity and evidence — the same tools human scholars use to navigate the past.

---

## 6. The "Cold Start" Challenge & Call for Collaboration

We are currently in the infrastructure-building phase. While the IDEA framework and the input interfaces are reaching maturity, the primary challenge remains the scale of data ingestion.
* **The Bottleneck:** Manually annotating hundreds of thousands of ancient coins with the depth required by IDEA is not feasible through human labor alone.
* **AI Pipelines:** We are developing complex AI-driven pipelines to migrate and structure legacy data from our predecessor project, Corpus Nummorum and other sources. These pipelines utilize IDEA's `pattern` feature to generate initial structures that can be reused both, by AI and human to build the detailled datasets.
* **Open Invitation:** We invite experts in Natural Language Processing (NLP) and Computer Vision / Image Analysis to collaborate with us. The complexity of ancient iconography provides a unique playground for testing and refining next-generation information extraction models.