# IN.IDEA Core

This module contains the formal technical specification and reference implementation of the IN.IDEA Core. It defines the fundamental structure required to describe units, compositions, and epistemic interpretations.

## Quick Links
* **Architecture:** For the theoretical foundation, see [`architecture.md`](../../docs/01_architecture.md).
* **Scaling:** Learn about our *O*(1) traversal strategy in [`performance-and-scaling.md`](../../docs/02_performance-and-scaling.md).

## Technical Specifications
* **[`nodes-and-edges.md`](nodes-and-edges.md):** Definition of all Core labels, properties, and relationships.
* **[`data-dictionary.md`](data-dictionary.md):** Allowed values for Enums (e.g., status, chromaticity).
* **[`fixtures.md`](fixtures.md):** Documentation of the provided test datasets.
* **[`queries.md`](queries.md):** Example Cypher queries for common analytical tasks.

## Deployment
To initialize a Neo4j instance with the IN.IDEA Core, execute the Cypher scripts in the following order (or let the seeder in our docker-compose.yml do its job):
1. [`00_constraints.cypher`](00_constraints.cypher): Enforces uniqueness and required properties.
2. [`01_index.cypher`](01_index.cypher): Optimizes lookup performance.
3. [`99_fixtures.cypher`](99_fixtures.cypher): Ingests the sample graph data described in [`fixtures.md`](fixtures.md).

**Note:** As per the [Golden Rule of Extension](../../docs/01_architecture.md), any other module must build upon this Core without altering its four-layer logic.