// --- Interpretations ---
CREATE INDEX interpretation_status IF NOT EXISTS FOR (n:Interpretation) ON (n.status);
CREATE INDEX interpretation_certainty IF NOT EXISTS FOR (n:Interpretation) ON (n.certainty);
CREATE INDEX interpretation_status_certainty IF NOT EXISTS FOR (n:Interpretation) ON (n.status, n.certainty);

// --- Readings ---
CREATE INDEX reading_status IF NOT EXISTS FOR (n:Reading) ON (n.status);
CREATE INDEX reading_certainty IF NOT EXISTS FOR (n:Reading) ON (n.certainty);
CREATE INDEX reading_status_certainty IF NOT EXISTS FOR (n:Reading) ON (n.status, n.certainty);

// --- Comparisons ---
CREATE INDEX comparison_similarity IF NOT EXISTS FOR (n:CompositionComparison) ON (n.similarity);

// --- Concepts ---
CREATE INDEX concept_path_lookup IF NOT EXISTS FOR (n:Concept) ON (n.concept_path_ids);
