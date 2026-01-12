# IN.IDEA Documentation Overview

This directory contains the formal documentation for the **Iconographical Definitional Epistemological Architecture (IN.IDEA)**. It covers the theoretical foundations, the technical architecture, and strategies for handling large-scale research data.

## Documentation Modules

### [Conceptual Framework](00_conceptual-framework.md)

* **Purpose:** Defines the mission and the "Manifesto" of the project.
* **Key Topics:** IN.IDEA as a catalyst for the **ThING** ontology, the critique of CIDOC CRM for mass data, and the mandate for modeling scientific uncertainty.

### [Architecture](01_architecture.md)

* **Purpose:** Detailed technical and structural overview of the graph framework.
* **Key Topics:** The Four-Layer Architecture (Object, Formal, Epistemic, Ontological), naming conventions, and the core design philosophy.

### [Performance & Scaling](02_performance-and-scaling.md)

* **Purpose:** Documentation of optimization strategies for large datasets.
* **Key Topics:** Materialized path arrays for concept hierarchies and shortcut edges for "Gold Standard" data bypasses.

### [How to annotate using IN.IDEA](03_how-to-annotate-using-in-idea.md)

* **Purpose:** A tutorial on how to annotate IN.IDEA datasets.
* **Key Topics:** Input and Modelling.

### [AI Annotation Pipeline](04_ai-annotation-pipeline.md)

* **Purpose:** Concept for an AI powered annotation pipeline.
* **Key Topics:** How to break the "Cold Start" problem using AI and IN.IDEA's pattern mechanism.

### [Trustworthy AI](05_trustworthy-ai.md)

* **Purpose:** IN.IDEA's Epistemic Layer III as a blueprint for a "glas-box" AI.
* **Key Topics:** Integration of IN.IDEA core features into a next generation Agentic AI.

### ETL & Mapping Logic (Deferred)

* **Status:** This module is currently a placeholder.
* **Objective:** Future documentation will define the mapping between the PostgreSQL Single Source of Truth (SSoT) and the Graph projection.

### [Glossary](99_glossary.md)

* **Purpose:** A bridge for interdisciplinary communication.
* **Key Topics:** Shared definitions for numismatic terms, graph engineering patterns, and epistemic metadata.


## [IN.IDEA Core Documentation](modules/00_core)

* To view the Core node and edge specifications, see [modules/00_core/nodes-and-edges.md](modules/00_core/nodes-and-edges.md) and [modules/00_core/data-dictionary.md](modules/00_core/data-dictionary.md).
* To view the Core fixtures, see [modules/00_core/fixtures.md](modules/00_core/fixtures.md) and [modules/00_core/queries.md](modules/00_core/queries.md).