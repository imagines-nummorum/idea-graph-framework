// --- Ontology ---
CREATE CONSTRAINT concept_id_unique IF NOT EXISTS FOR (n:Concept) REQUIRE n.concept_id IS UNIQUE;
CREATE CONSTRAINT architectonic_id_unique IF NOT EXISTS FOR (n:Architectonic) REQUIRE n.architectonic_id IS UNIQUE;

// --- Epistemic Layer & Agents ---
CREATE CONSTRAINT agent_id_unique IF NOT EXISTS FOR (n:Agent) REQUIRE n.agent_id IS UNIQUE;
CREATE CONSTRAINT interpretation_id_unique IF NOT EXISTS FOR (n:Interpretation) REQUIRE n.interpretation_id IS UNIQUE;
CREATE CONSTRAINT reading_id_unique IF NOT EXISTS FOR (n:Reading) REQUIRE n.reading_id IS UNIQUE;
CREATE CONSTRAINT source_reference_id_unique IF NOT EXISTS FOR (n:SourceReference) REQUIRE n.source_reference_id IS UNIQUE;
CREATE CONSTRAINT source_id_unique IF NOT EXISTS FOR (n:Source) REQUIRE n.source_id IS UNIQUE;

// --- Analysis Layer ---
CREATE CONSTRAINT unit_id_unique IF NOT EXISTS FOR (n:Unit) REQUIRE n.unit_id IS UNIQUE;
CREATE CONSTRAINT composition_id_unique IF NOT EXISTS FOR (n:Composition) REQUIRE n.composition_id IS UNIQUE;
CREATE CONSTRAINT composition_context_id_unique IF NOT EXISTS FOR (n:CompositionContext) REQUIRE n.composition_context_id IS UNIQUE;
CREATE CONSTRAINT composition_entity_id_unique IF NOT EXISTS FOR (n:CompositionEntity) REQUIRE n.composition_entity_id IS UNIQUE;
CREATE CONSTRAINT composition_feature_id_unique IF NOT EXISTS FOR (n:CompositionFeature) REQUIRE n.composition_feature_id IS UNIQUE;
CREATE CONSTRAINT composition_relation_id_unique IF NOT EXISTS FOR (n:CompositionRelation) REQUIRE n.composition_relation_id IS UNIQUE;
CREATE CONSTRAINT composition_modifier_id_unique IF NOT EXISTS FOR (n:CompositionModifier) REQUIRE n.composition_modifier_id IS UNIQUE;
CREATE CONSTRAINT composition_event_id_unique IF NOT EXISTS FOR (n:CompositionEvent) REQUIRE n.composition_event_id IS UNIQUE;
CREATE CONSTRAINT composition_group_id_unique IF NOT EXISTS FOR (n:CompositionGroup) REQUIRE n.composition_group_id IS UNIQUE;

// --- Patterns ---
CREATE CONSTRAINT composition_pattern_id_unique IF NOT EXISTS FOR (n:CompositionPattern) REQUIRE n.composition_pattern_id IS UNIQUE;
CREATE CONSTRAINT pattern_id_unique IF NOT EXISTS FOR (n:Pattern) REQUIRE n.pattern_id IS UNIQUE;
CREATE CONSTRAINT pattern_entity_id_unique IF NOT EXISTS FOR (n:PatternEntity) REQUIRE n.pattern_entity_id IS UNIQUE;
CREATE CONSTRAINT pattern_relation_id_unique IF NOT EXISTS FOR (n:PatternRelation) REQUIRE n.pattern_relation_id IS UNIQUE;
CREATE CONSTRAINT pattern_group_id_unique IF NOT EXISTS FOR (n:PatternGroup) REQUIRE n.pattern_group_id IS UNIQUE;

// --- Comparisons ---
CREATE CONSTRAINT composition_comparison_id_unique IF NOT EXISTS FOR (n:CompositionComparison) REQUIRE n.composition_comparison_id IS UNIQUE;
CREATE CONSTRAINT composition_parallel_id_unique IF NOT EXISTS FOR (n:CompositionParallel) REQUIRE n.composition_parallel_id IS UNIQUE;
