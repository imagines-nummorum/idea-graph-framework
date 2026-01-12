# IN.IDEA: Modular Framework Overview

IN.IDEA is built as a strictly modular system to ensure that the abstract **Core** remains lean and high-performing while allowing for domain-specific or feature-rich extensions.

## 1. Active Modules

### [Core](00_core)

* **Status:** Active (v0.9).
* **Description:** The domain-agnostic engine of IN.IDEA.
* **Contents:** Formal specifications for the four-layer architecture, basic node labels (e.g., `Unit`, `Composition`, `Interpretation`), and core edge logic.
* **Golden Rule:** All other modules must extend these labels without altering the fundamental directionality or logic of the Core.


## 2. Planned Extensions (In Development)

The following modules are currently placeholders, representing the next phase of the IN.IDEA implementation.

### [Ontology](05_ontology)

* **Status:** Planned / Concept Phase.
* **Scope:** Extended Core
* **Objective:** Adding the "semantic flesh" to the Ontological Layer to fully represent the **ThING** (Thesaurus Iconographicus Nummorum Graecorum).
* **Planned Features:**
  * **Multi-language Support:** Labels and definitions in EN, DE, LAT, GRC.
  * **LOD-Mapping:** Explicit edges to external authorities (e.g., Getty AAT, Wikidata, Nomisma.org).
  * **Semantic Properties:** Detailed conceptual descriptions and scope notes.

### [Numismatics](10_numismatics)

* **Status:** Planned / Concept Phase.
* **Scope:** Domain-specific
* **Objective:** The first domain-specific implementation of IN.IDEA, tailored for ancient coinage.
* **Planned Features:**
  * **Specialized Labels:** Extending `Unit` with `Coin` and `Composition` with `CoinObverse` or `CoinReverse`.
  * **Numismatic Metadata:** Integrating physical properties specific to coins (e.g., weight, diameter, die-axis).


## 3. Future Concepts & Considerations

To further expand the scope of IN.IDEA, we are considering the following functional modules:

* **Sources Extension:** Enhancing the Epistemic Layer with deeper bibliographic structures. While basic `Source` nodes exist in the Core, this module would allow for complex modeling of archival hierarchies.
* **Provenance Extension:** Extending the Object Layer (Layer I) to track the "Life of the Object." This includes historical ownership, archaeological find spots, and current museum locations.


### How to contribute

We invite researchers from all fields of visual culture to develop their own modules based on the IN.IDEA Core. If you are interested in creating an own extension, please refer to our [CONTRIBUTING.md](../CONTRIBUTING.md) guide.