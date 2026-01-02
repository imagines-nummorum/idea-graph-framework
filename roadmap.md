# IDEA: Roadmap 2026

This document outlines the development milestones for the IDEA framework in 2026. Following the initial release of the **IDEA Core**, which serves as a domain-agnostic engine for formal analysis, our focus shifts toward domain-specific extensions, the implementation of the relational Single Source of Truth (SSoT), and the development of internal tooling.

---

## Phase 1: Refining the Core & Domain Extensions (Q1 2026)

The first quarter focuses on stabilizing the core architecture and expanding the framework into specific scientific domains.

* **January: Community Review**
  * Open feedback loop and peer review phase following the initial GitHub release. Sie [CONTRIBUTING.md](CONTRIBUTING.md)
  * Refinement of the **Four-Layer Architecture** (Object, Formal Analysis, Epistemic, and Ontological).

* **February: Module Expansion**
  * **Release: Ontology Module:** Introducing human-readable labels and semantic definitions for the Ontology Layer, in our case the **ThING** (Thesaurus Iconographicus Nummorum Graecorum).
  * **Release: Numismatics Module:** Providing specialized labels and properties for coin-specific data, extending the IDEA Core without altering its fundamental logic.

* **February/March: Scientific Communication**
  * Submission of the foundational paper on the IDEA framework to academic platforms.

* **March: Relational SSoT Design**
  * Drafting the SQL schema for the **PostgreSQL** backend.
  * Establishing the 1:1 traceability between the graph projection and the relational SSoT primary keys using unique identifiers.

---

## Phase 2: Technical Implementation & Tooling (Q2 2026)

In the second quarter, IDEA transitions from a conceptual model into a functional data engineering environment.

* **April: Infrastructure Deployment**
  * Setup of the IDEA test environment and API endpoints.
  * Implementation of the **Schema-on-Write** ETL process to ensure data remains strictly typed and verifiable.

* **June: Internal Editor Prototype**
  * Development of a **Vue.js** based Single Page Application (SPA).
  * The editor will enforce the "Golden Rule" of modular design, ensuring extensions never alter core edge directionality.

---

## Future Outlook: Public Engagement (Late 2026 & Beyond)

* **Prototype: ThING Public Portal**
  * Development of a public-facing website with graph-based search capabilities.
  * Implementation of performance-optimized design patterns, such as **materialized hierarchy paths**, to ensure  or  performance for complex ancestral lookups.

---

> **Note on Capacity**: IDEA is an academic research project driven by a small, dedicated team with limited personnel resources. Please be aware that even short-term absences or unforeseen events can lead to significant delays in this roadmap. We prioritize intellectual honesty and data integrity over rapid implementation.
