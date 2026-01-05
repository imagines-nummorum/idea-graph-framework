# Contributing to IDEA

Thank you for your interest in the **Iconographical Definitional Epistemological Architecture (IDEA)**. We welcome feedback and contributions that help refine this framework for the structured description of images and the modeling of uncertainty.

## 1. Interaction Policy: Issue First

To ensure that all efforts are aligned with our long-term roadmap and architectural integrity, we follow a **"ticket-first" workflow**. Please open a GitHub Issue to discuss any proposed changes before submitting a Pull Request.


## 2. Types of Contributions

We distinguish between different levels of contribution to maintain a focused project scope:

### A. Bugs, Feedback & Refinements

We highly encourage reports on bugs or conceptual inconsistencies.

* **Edge Case Suitability:** We especially value feedback from users who test IDEA with their own datasets. Please report any "edge cases" where the current model reaches its limits.

### B. Core Enhancements

Changes to 0-Modules like `00_core` or new core-level modules:

* **Requirement:** Must be in strict alignment with our core design principles (e.g., the four-layer logic) and the overall project goals.

### C. Domain Modules: Within Scope (Ancient World)

If you wish to develop a module for a specific domain within our primary research scope (Numismatics, Archaeology, Ancient History):

* **Policy:** Please contact us first. These contributions are generally very welcome and may be integrated into the main repository after review.

### D. Domain Modules: Outside Scope

IDEA is designed to be versatile, but our resources are focused on the Ancient World.

* **Policy:** If you are developing a module for a different field (e.g., Modern Art, Biology, etc.), **we recommend maintaining a separate repository.**
* **Integration:** You should treat IDEA as a dependency. This keeps our core lean while allowing you full control over your domain-specific development. Remember: *IDEA is our tool, not the goal of our project.*


## 3. Forking, Adaptations & License

In accordance with the **Apache License 2.0**:

* **Freedom to Adapt:** We explicitly encourage you to fork, adapt, and transform IDEA for your own purposes.
* **Attribution:** Any derivative work must maintain proper attribution to the original IDEA repository and its authors.
* **Notification:** We are always happy to hear about how IDEA is being used or adapted, even if your project leaves our original scope.


## 4. Academic Collaboration

If you are interested in a deeper research collaboration that goes beyond technical contributions to the graph framework:

* **Contact:** Please reach out to our **Principal Investigators (PIs)**. Contact details can be found in on our [Homepage](https://www.imagines-nummorum.eu/en/contact).


## 5. Architectural Integrity: The Golden Rule

Every contribution, especially when proposing new modules or refinements, must adhere to the **IDEA Core Architecture**:

* **Immutable Four-Layer Logic:** You may add specific node properties or specialized leaf-nodes, but you must **never alter the fundamental four-layer structure** (Object → Formal → Epistemic → Ontological).
* **Directionality:** Edges must always flow from the specific/concrete to the abstract/conceptual.
* **Epistemic Transparency:** No semantic link between a visual element in object context and a concept should exist without an intermediate `Interpretation` node.

## 6. Style and Conventions

We recommand using the graph as an projection to keep a clear scheme.
Consistency is key for a scalable graph. Please follow these naming conventions in all code contributions:

| Element | Convention | Example |
| --- | --- | --- |
| **Labels (Nodes)** | PascalCase | `CompositionEntity`, `AIAgent` |
| **Properties** | lower_snake_case | `reasoning_statement`, `certainty` |
| **Edges** | UPPER_SNAKE_CASE | `IDENTIFIED_AS_CONCEPT` |
| **Uniqueness** | `_id` suffix | `unit_id`, `concept_id` |