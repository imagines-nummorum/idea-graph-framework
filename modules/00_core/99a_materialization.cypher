// ---------------------------------------------------------------------------
// PERFORMANCE OPTIMIZATION: Hierarchical Flattening (Materialized Paths)
// This script implements the conceptual design for O(1) hierarchy lookups
// as defined in docs/02_performance-and-scaling.md
// ---------------------------------------------------------------------------

// 1. Identify all Concept nodes loaded from fixtures
MATCH (c:Concept)

// 2. Traversal: Find all ancestors via the :IS_A relationship
// The *0.. syntax ensures the path includes the node itself (depth 0).
// The path follows the ontology from specific to general concepts.
MATCH (c)-[:IS_A*0..]->(ancestor:Concept)

// 3. Aggregate and handle potential multiple inheritance (DAG)
// DISTINCT ensures IDs are unique even if multiple paths lead to the same root.
WITH c, collect(DISTINCT ancestor.concept_id) AS all_ancestor_ids

// 4. Materialize the path property onto the node
// This allows bypassing recursive JOINs/Traversals during query time.
SET c.concept_path_ids = all_ancestor_ids

// 5. Provide feedback for the Seeder log
// RETURN count(c) AS MaterializedConcepts;