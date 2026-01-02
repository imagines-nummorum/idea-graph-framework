# Glossary

This glossary provides shared definitions to bridge the gap between numismatic research and graph data engineering.

## 1. Domain-Specific Terms (Numismatics & Iconography)

* **[Imagines Nummorum](https://www.imagines-nummorum.eu/en):** Our research intiative at the [Berlin-Brandenburg Academy of Sciences and Humanities](https://www.bbaw.de/en/)
* **[Corpus Nummorum](https://www.corpus-nummorum.eu/?lg=en):** Our previous research intiative, which we are still actively maintaining
* **ThING (Thesaurus Iconographicus Nummorum Graecorum):** The central, multidimensional ontology (Tree of Concepts) that serves as the semantic backbone for our studies.

---

## 2. Technical Terms

* **SSoT (Single Source of Truth):** The primary relational database (PostgreSQL) where all data is strictly validated and stored before being projected into the graph.
* **Reification:** The process of turning an abstract relationship (like an interpretation) into a physical node in the graph to allow for properties like `certainty` and `reasoning_statement`.
* **Hub-and-Spoke (Centroid Model):** A design pattern where a central node (the Hub) connects multiple entities to avoid a quadratic explosion of direct relationships (Spokes).
* **Materialized Path:** A performance optimization where the entire lineage of a concept is stored as an array (`concept_path_ids`) on the node itself to avoid recursive queries.

---

## 3. Architecture

* **Unit:** The physical or virtual object acting as the information carrier (e.g., a specific ancient coin).
* **Composition:** A visual container representing a specific side or area of a Unit, housing all formal elements identified during analysis.
* **Pattern:** An abstract iconographical blueprint or "preset" used to identify recurring scene structures across different Compositions.
* **Entity:** Any discrete being or object (concrete or abstract).
* **Feature:** Attributes, states, or typographic properties belonging to an Entity.
* **Relation:** Directed atomic actions or relationships between two Entities.
* **Modifier:** Specific details describing the execution of a Relation (e.g., handedness).
* **Event:** Macro-level actions composed of multiple atomic Relations.
* **Context:** References to external frameworks like mythology, history, or publication contexts.
* **Group:** Logical containers or spatial regions (e.g., a text block or a logical arrangement). (no Concept)

---

## 4. Epistemic Terms

* **Certainty:** A floating-point value (0.0 to 1.0) representing the level of confidence an Agent has in a specific interpretation.
* **Interpretation Node:** The mandatory intermediary node between a formal element and its semantic concept, used to model the "epistemic act" of identification.
* **Architectonic:** Meta-concepts used to describe the methodology or the source of uncertainty (e.g., "damaged surface" or "stylistic comparison").