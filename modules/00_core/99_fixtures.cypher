CALL db.awaitIndexes(300);
:begin
UNWIND [{interpretation_id:"interpretation-bb-human-holding-object", properties:{certainty:1.0, reasoning_statement:"(human) hand is holding an object", timestamp:"2025-12-22"}}, {interpretation_id:"interpretation-at-human-holding-object", properties:{certainty:1.0, reasoning_statement:"(human) hand is holding an object", timestamp:"2025-12-22"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:PatternRecognition:Fixture;
UNWIND [{composition_event_id:"event-at-presentation", properties:{}}, {composition_event_id:"event-bb-presentation", properties:{}}] AS row
MERGE (n:CompositionEvent{composition_event_id: row.composition_event_id}) SET n += row.properties SET n:Fixture;
UNWIND [{interpretation_id:"interpretation-at-apple-color", properties:{certainty:1.0, reasoning_statement:"The image has no color cast", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-at-human-visual-scope", properties:{certainty:1.0, reasoning_statement:"Obvious cropping of the subject at the right edge of the frame.", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-bb-human-visual-scope", properties:{certainty:0.95, reasoning_statement:"Cropped by frame", timestamp:"2025-12-21", status:"Primary"}}, {interpretation_id:"interpretation-bb-sphere-color", properties:{certainty:0.9, reasoning_statement:"Distinct shade", timestamp:"2025-12-21", status:"Alternative"}}, {interpretation_id:"interpretation-bb-glyph-color", properties:{certainty:1.0, reasoning_statement:"Distinct Shade", timestamp:"2025-12-21", status:"Alternative"}}, {interpretation_id:"interpretation-bb-circle-color", properties:{certainty:1.0, reasoning_statement:"Distinct Shade", timestamp:"2025-12-21", status:"Alternative"}}, {interpretation_id:"interpretation-bb-glyph-case", properties:{certainty:0.8, reasoning_statement:"Capitalized", timestamp:"2025-12-21", status:"Rejected"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:Fixture:FeatureInterpretation;
UNWIND [{composition_modifier_id:"modifier-at-using-right-hand", properties:{}}, {composition_modifier_id:"modifier-bb-using-right-hand", properties:{}}] AS row
MERGE (n:CompositionModifier{composition_modifier_id: row.composition_modifier_id}) SET n += row.properties SET n:Fixture;
UNWIND [{interpretation_id:"interpretation-at-presentation", properties:{certainty:0.75, reasoning_statement:"Composition is designed to maximize the visibility of the object", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-bb-presentation", properties:{certainty:0.75, reasoning_statement:"Composition is designed to maximize the visibility of the object", timestamp:"2025-12-22", status:"Primary"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:Fixture:EventInterpretation;
UNWIND [{pattern_id:"pattern-human-holding-object", properties:{}}] AS row
MERGE (n:Pattern{pattern_id: row.pattern_id}) SET n += row.properties SET n:Fixture;
UNWIND [{unit_id:"unit-apple-tomato", properties:{}}, {unit_id:"unit-billiard-ball", properties:{}}] AS row
MERGE (n:Unit{unit_id: row.unit_id}) SET n += row.properties SET n:Fixture;
UNWIND [{reading_id:"reading-bb-7", properties:{read_string:7, certainty:0.5, lang:"EN", reasoning_statement:"Commen Scheme, but ambiguous", timestamp:"2025-12-21", status:"Primary"}}, {reading_id:"reading-bb-l", properties:{read_string:"L", certainty:0.5, lang:"EN", reasoning_statement:"Commen Scheme, but ambiguous", timestamp:"2025-12-21", status:"Rejected"}}] AS row
MERGE (n:Reading{reading_id: row.reading_id}) SET n += row.properties SET n:Fixture;
UNWIND [{agent_id:"agent-ai", properties:{}}] AS row
MERGE (n:Agent{agent_id: row.agent_id}) SET n += row.properties SET n:AIAgent:Fixture;
UNWIND [{composition_parallel_id:"parallel-at-bb", properties:{similarity_deviation:0, assertion_count:2, similarity_average:1.0}}] AS row
MERGE (n:CompositionParallel{composition_parallel_id: row.composition_parallel_id}) SET n += row.properties SET n:Fixture;
UNWIND [{composition_feature_id:"feature-at-apple-color", properties:{}}, {composition_feature_id:"feature-at-human-visual-scope", properties:{}}, {composition_feature_id:"feature-bb-sphere-color", properties:{}}, {composition_feature_id:"feature-bb-human-visual-scope", properties:{}}, {composition_feature_id:"feature-bb-glyph-color", properties:{}}, {composition_feature_id:"feature-bb-circle-color", properties:{}}, {composition_feature_id:"feature-bb-glyph-case", properties:{}}] AS row
MERGE (n:CompositionFeature{composition_feature_id: row.composition_feature_id}) SET n += row.properties SET n:Fixture;
UNWIND [{concept_id:"concept-functional-demo", properties:{}}] AS row
MERGE (n:Concept{concept_id: row.concept_id}) SET n += row.properties SET n:Context:Fixture;
UNWIND [{architectonic_id:"architectonic-source-of-uncertainty", properties:{}}, {architectonic_id:"architectonic-missing-attribute", properties:{}}, {architectonic_id:"architectonic-ambiguity", properties:{}}, {architectonic_id:"architectonic-logical-deduction", properties:{}}, {architectonic_id:"architectonic-epistemic-mode", properties:{}}, {architectonic_id:"architectonic-evidentiary-relationship", properties:{}}, {architectonic_id:"architectonic-conflicting", properties:{}}, {architectonic_id:"architectonic-concurring", properties:{}}, {architectonic_id:"architectonic-compositional-parallel", properties:{}}, {architectonic_id:"architectonic-parallel-type", properties:{}}] AS row
MERGE (n:Architectonic{architectonic_id: row.architectonic_id}) SET n += row.properties SET n:Methodology:Fixture;
UNWIND [{composition_pattern_id:"pattern-at-human-holding-object", properties:{}}, {composition_pattern_id:"pattern-bb-humand-holding-object", properties:{}}] AS row
MERGE (n:CompositionPattern{composition_pattern_id: row.composition_pattern_id}) SET n += row.properties SET n:Fixture;
UNWIND [{composition_relation_id:"relation-at-holding", properties:{}}, {composition_relation_id:"relation-bb-holding", properties:{}}] AS row
MERGE (n:CompositionRelation{composition_relation_id: row.composition_relation_id}) SET n += row.properties SET n:Fixture;
UNWIND [{source_reference_id:"reference-at-apple-conflicting", properties:{reference:"img-at-apple-conflicting", refrence_statement:"apple reference image shows stem"}}, {source_reference_id:"reference-at-apple-concurring", properties:{reference:"img-at-apple-concurring", refrence_statement:"matching reference image of apple"}}, {source_reference_id:"reference-bb-billiard-ball-concurring", properties:{reference:"img-bb-ex", refrence_statement:"matching reference image of a billiard ball"}}] AS row
MERGE (n:SourceReference{source_reference_id: row.source_reference_id}) SET n += row.properties SET n:Fixture;
UNWIND [{concept_id:"concept-holding", properties:{}}, {concept_id:"concept-handling", properties:{}}] AS row
MERGE (n:Concept{concept_id: row.concept_id}) SET n += row.properties SET n:Relation:Fixture;
UNWIND [{interpretation_id:"interpretation-at-using-right-hand", properties:{certainty:1.0, reasoning_statement:"Arrangement of fingers/thumb indicates the right hand", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-bb-using-right-hand", properties:{certainty:0.9, reasoning_statement:"Common Scheme", timestamp:"2025-12-21", status:"Primary"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:ModifierInterpretation:Fixture;
UNWIND [{interpretation_id:"interpretation-at-tomato", properties:{certainty:0.5, reasoning_statement:"Tomato texture, uncommon shape", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-at-apple", properties:{certainty:0.4, reasoning_statement:"apple shape, but no stem, uncommon texture", timestamp:"2025-12-22", status:"Alternative"}}, {interpretation_id:"interpretation-bb-human", properties:{certainty:0.9, reasoning_statement:"Common Scheme", timestamp:"2025-12-21", status:"Primary"}}, {interpretation_id:"interpretation-at-human", properties:{certainty:1.0, reasoning_statement:"Skin texture and morphology indicate a human body", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-billiard-ball", properties:{certainty:1.0, reasoning_statement:"Object is clearly a billiard ball nr. 7", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-bb-sphere", properties:{certainty:0.8, reasoning_statement:"Common Scheme, partly covered", timestamp:"2025-12-21", status:"Alternative"}}, {interpretation_id:"interpretation-bb-glyph-l", properties:{certainty:0.5, reasoning_statement:"Commen Scheme, but ambiguous", timestamp:"2025-12-21", status:"Rejected"}}, {interpretation_id:"interpretation-bb-glyph-7", properties:{certainty:0.5, reasoning_statement:"Commen Scheme, but ambiguous", timestamp:"2025-12-21", status:"Alternative"}}, {interpretation_id:"interpretation-bb-circle", properties:{certainty:1.0, reasoning_statement:"Common Scheme", timestamp:"2025-12-21", status:"Alternative"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:EntityInterpretation:Fixture;
UNWIND [{composition_entity_id:"entity-at-apple-tomato", properties:{}}, {composition_entity_id:"entity-at-human", properties:{}}, {composition_entity_id:"entity-bb-human", properties:{}}, {composition_entity_id:"entity-bb-billiard-ball-sphere", properties:{}}, {composition_entity_id:"entity-bb-circle", properties:{}}, {composition_entity_id:"entity-bb-glyph", properties:{}}] AS row
MERGE (n:CompositionEntity{composition_entity_id: row.composition_entity_id}) SET n += row.properties SET n:Fixture;
UNWIND [{interpretation_id:"interpretation-at-functional-demo", properties:{certainty:1.0, reasoning_statement:"Defined by pulication context", timestamp:"2025-12-22", status:"Primary"}}, {interpretation_id:"interpretation-bb-functional-demo", properties:{certainty:1.0, reasoning_statement:"Defined by pulication context", timestamp:"2025-12-21", status:"Primary"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:Fixture:ContextInterpretation;
UNWIND [{interpretation_id:"interpretation-bb-holding", properties:{certainty:0.8, reasoning_statement:"Common Scheme", timestamp:"2025-12-21", status:"Primary"}}, {interpretation_id:"interpretation-at-holding", properties:{certainty:0.9, reasoning_statement:"Stationary posture suggests passive action", timestamp:"2025-12-22", status:"Primary"}}] AS row
MERGE (n:Interpretation{interpretation_id: row.interpretation_id}) SET n += row.properties SET n:RelationInterpretation:Fixture;
UNWIND [{concept_id:"concept-using-right-hand", properties:{}}, {concept_id:"concept-using-hand", properties:{}}] AS row
MERGE (n:Concept{concept_id: row.concept_id}) SET n += row.properties SET n:Fixture:Modifier;
UNWIND [{pattern_relation_id:"relation-holding", properties:{}}] AS row
MERGE (n:PatternRelation{pattern_relation_id: row.pattern_relation_id}) SET n += row.properties SET n:Fixture;
UNWIND [{concept_id:"concept-tomato", properties:{}}, {concept_id:"concept-fruit", properties:{}}, {concept_id:"concept-apple", properties:{}}, {concept_id:"concept-object", properties:{}}, {concept_id:"concept-human", properties:{}}, {concept_id:"concept-figure", properties:{}}, {concept_id:"concept-billiard-ball-7", properties:{}}, {concept_id:"concept-sphere", properties:{}}, {concept_id:"concept-letter-l", properties:{}}, {concept_id:"concept-digit-7", properties:{}}, {concept_id:"concept-digit", properties:{}}, {concept_id:"concept-graphic-character", properties:{}}, {concept_id:"concept-letter", properties:{}}, {concept_id:"concept-bb-circle", properties:{}}, {concept_id:"concept-bb-geometric-shape", properties:{}}, {concept_id:"concept-shape", properties:{}}, {concept_id:"concept-billiard-ball", properties:{}}, {concept_id:"concept-sports-equipment", properties:{}}] AS row
MERGE (n:Concept{concept_id: row.concept_id}) SET n += row.properties SET n:Entity:Fixture;
UNWIND [{concept_id:"concept-presentation", properties:{}}, {concept_id:"concept-display", properties:{}}] AS row
MERGE (n:Concept{concept_id: row.concept_id}) SET n += row.properties SET n:Event:Fixture;
UNWIND [{composition_context_id:"context-at-functional-demo", properties:{}}, {composition_context_id:"context-bb-functional-demo", properties:{}}] AS row
MERGE (n:CompositionContext{composition_context_id: row.composition_context_id}) SET n += row.properties SET n:Fixture;
UNWIND [{pattern_entity_id:"entity-object", properties:{}}, {pattern_entity_id:"entity-human", properties:{}}] AS row
MERGE (n:PatternEntity{pattern_entity_id: row.pattern_entity_id}) SET n += row.properties SET n:Fixture;
UNWIND [{concept_id:"concept-red", properties:{}}, {concept_id:"concept-detail-hand", properties:{}}, {concept_id:"concept-human-visual-scope", properties:{}}, {concept_id:"concept-visual-scope", properties:{}}, {concept_id:"concept-black", properties:{}}, {concept_id:"concept-white", properties:{}}, {concept_id:"concept-color", properties:{}}, {concept_id:"concept-uppercase", properties:{}}, {concept_id:"concept-case", properties:{}}, {concept_id:"concept-typographic-attribute", properties:{}}] AS row
MERGE (n:Concept{concept_id: row.concept_id}) SET n += row.properties SET n:Fixture:Feature;
UNWIND [{composition_group_id:"group-bb-billiard-ball", properties:{group_function:"LogicalUnit"}}, {composition_group_id:"group-bb-text", properties:{group_function:"TextContainer"}}] AS row
MERGE (n:CompositionGroup{composition_group_id: row.composition_group_id}) SET n += row.properties SET n:Fixture;
UNWIND [{composition_comparison_id:"comparison-at", properties:{similarity:1.0, reasoning_statement:"Identical composition of right hand holding object", timestamp:"2025-12-22"}}, {composition_comparison_id:"comparison-bb", properties:{similarity:1.0, reasoning_statement:"Identical composition of right hand holding object", timestamp:"2025-12-22"}}] AS row
MERGE (n:CompositionComparison{composition_comparison_id: row.composition_comparison_id}) SET n += row.properties SET n:Fixture;
UNWIND [{source_id:"source-at-reference-catalogue", properties:{}}, {source_id:"source-bb-reference-catalogue", properties:{}}] AS row
MERGE (n:Source{source_id: row.source_id}) SET n += row.properties SET n:Fixture;
UNWIND [{agent_id:"agent-human", properties:{}}] AS row
MERGE (n:Agent{agent_id: row.agent_id}) SET n += row.properties SET n:Fixture:HumanAgent;
UNWIND [{composition_id:"composition-apple-tomato", properties:{chromaticity:"Polychromatic"}}, {composition_id:"composition-billiard-ball", properties:{chromaticity:"Polychromatic"}}] AS row
MERGE (n:Composition{composition_id: row.composition_id}) SET n += row.properties SET n:Fixture;
:commit
:begin
UNWIND [{start: {unit_id:"unit-apple-tomato"}, end: {composition_id:"composition-apple-tomato"}, properties:{}}, {start: {unit_id:"unit-billiard-ball"}, end: {composition_id:"composition-billiard-ball"}, properties:{}}] AS row
MATCH (start:Unit{unit_id: row.start.unit_id})
MATCH (end:Composition{composition_id: row.end.composition_id})
MERGE (start)-[r:HAS_COMPOSITION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-holding"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:ACCEPTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {source_reference_id:"reference-at-apple-concurring"}, end: {source_id:"source-at-reference-catalogue"}, properties:{}}, {start: {source_reference_id:"reference-at-apple-conflicting"}, end: {source_id:"source-at-reference-catalogue"}, properties:{}}, {start: {source_reference_id:"reference-bb-billiard-ball-concurring"}, end: {source_id:"source-bb-reference-catalogue"}, properties:{}}] AS row
MATCH (start:SourceReference{source_reference_id: row.start.source_reference_id})
MATCH (end:Source{source_id: row.end.source_id})
MERGE (start)-[r:HAS_SOURCE]->(end) SET r += row.properties;
UNWIND [{start: {composition_relation_id:"relation-bb-holding"}, end: {interpretation_id:"interpretation-bb-holding"}, properties:{}}, {start: {composition_relation_id:"relation-at-holding"}, end: {interpretation_id:"interpretation-at-holding"}, properties:{}}] AS row
MATCH (start:CompositionRelation{composition_relation_id: row.start.composition_relation_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_INTERPRETATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-tomato"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-at-apple"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-billiard-ball"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-at-human"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {pattern_relation_id:"relation-holding"}, end: {concept_id:"concept-holding"}, properties:{}}] AS row
MATCH (start:PatternRelation{pattern_relation_id: row.start.pattern_relation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:HAS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-using-right-hand"}, end: {agent_id:"agent-ai"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-apple-color"}, end: {concept_id:"concept-red"}, properties:{}}, {start: {interpretation_id:"interpretation-at-human-visual-scope"}, end: {concept_id:"concept-detail-hand"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-human-visual-scope"}, end: {concept_id:"concept-detail-hand"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-sphere-color"}, end: {concept_id:"concept-red"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-color"}, end: {concept_id:"concept-black"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-circle-color"}, end: {concept_id:"concept-white"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-case"}, end: {concept_id:"concept-uppercase"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {composition_id:"composition-apple-tomato"}, end: {composition_entity_id:"entity-at-apple-tomato"}, properties:{}}, {start: {composition_id:"composition-apple-tomato"}, end: {composition_entity_id:"entity-at-human"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_entity_id:"entity-bb-human"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_entity_id:"entity-bb-circle"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_entity_id:"entity-bb-billiard-ball-sphere"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_entity_id:"entity-bb-glyph"}, properties:{}}] AS row
MATCH (start:Composition{composition_id: row.start.composition_id})
MATCH (end:CompositionEntity{composition_entity_id: row.end.composition_entity_id})
MERGE (start)-[r:HAS_COMPOSITION_ENTITY]->(end) SET r += row.properties;
UNWIND [{start: {composition_entity_id:"entity-at-apple-tomato"}, end: {interpretation_id:"interpretation-at-apple"}, properties:{}}, {start: {composition_entity_id:"entity-at-human"}, end: {interpretation_id:"interpretation-at-human"}, properties:{}}, {start: {composition_entity_id:"entity-bb-billiard-ball-sphere"}, end: {interpretation_id:"interpretation-billiard-ball"}, properties:{}}, {start: {composition_entity_id:"entity-bb-billiard-ball-sphere"}, end: {interpretation_id:"interpretation-bb-sphere"}, properties:{}}, {start: {composition_entity_id:"entity-bb-human"}, end: {interpretation_id:"interpretation-bb-human"}, properties:{}}, {start: {composition_entity_id:"entity-bb-glyph"}, end: {interpretation_id:"interpretation-bb-glyph-l"}, properties:{}}, {start: {composition_entity_id:"entity-bb-circle"}, end: {interpretation_id:"interpretation-bb-circle"}, properties:{}}, {start: {composition_entity_id:"entity-bb-glyph"}, end: {interpretation_id:"interpretation-bb-glyph-7"}, properties:{}}, {start: {composition_entity_id:"entity-at-apple-tomato"}, end: {interpretation_id:"interpretation-at-tomato"}, properties:{}}] AS row
MATCH (start:CompositionEntity{composition_entity_id: row.start.composition_entity_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_INTERPRETATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-holding"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {reading_id:"reading-bb-7"}, end: {architectonic_id:"architectonic-ambiguity"}, properties:{}}, {start: {reading_id:"reading-bb-l"}, end: {architectonic_id:"architectonic-ambiguity"}, properties:{}}] AS row
MATCH (start:Reading{reading_id: row.start.reading_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:IMPAIRED_BY]->(end) SET r += row.properties;
UNWIND [{start: {architectonic_id:"architectonic-missing-attribute"}, end: {architectonic_id:"architectonic-source-of-uncertainty"}, properties:{}}, {start: {architectonic_id:"architectonic-logical-deduction"}, end: {architectonic_id:"architectonic-epistemic-mode"}, properties:{}}, {start: {architectonic_id:"architectonic-ambiguity"}, end: {architectonic_id:"architectonic-source-of-uncertainty"}, properties:{}}, {start: {architectonic_id:"architectonic-conflicting"}, end: {architectonic_id:"architectonic-evidentiary-relationship"}, properties:{}}, {start: {architectonic_id:"architectonic-concurring"}, end: {architectonic_id:"architectonic-evidentiary-relationship"}, properties:{}}, {start: {architectonic_id:"architectonic-compositional-parallel"}, end: {architectonic_id:"architectonic-parallel-type"}, properties:{}}] AS row
MATCH (start:Architectonic{architectonic_id: row.start.architectonic_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:IS_A]->(end) SET r += row.properties;
UNWIND [{start: {pattern_entity_id:"entity-object"}, end: {concept_id:"concept-object"}, properties:{}}, {start: {pattern_entity_id:"entity-human"}, end: {concept_id:"concept-human"}, properties:{}}] AS row
MATCH (start:PatternEntity{pattern_entity_id: row.start.pattern_entity_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:HAS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {composition_id:"composition-apple-tomato"}, end: {composition_pattern_id:"pattern-at-human-holding-object"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_pattern_id:"pattern-bb-humand-holding-object"}, properties:{}}] AS row
MATCH (start:Composition{composition_id: row.start.composition_id})
MATCH (end:CompositionPattern{composition_pattern_id: row.end.composition_pattern_id})
MERGE (start)-[r:HAS_PATTERN]->(end) SET r += row.properties;
UNWIND [{start: {composition_relation_id:"relation-at-holding"}, end: {composition_entity_id:"entity-at-apple-tomato"}, properties:{}}, {start: {composition_relation_id:"relation-bb-holding"}, end: {composition_entity_id:"entity-bb-billiard-ball-sphere"}, properties:{}}] AS row
MATCH (start:CompositionRelation{composition_relation_id: row.start.composition_relation_id})
MATCH (end:CompositionEntity{composition_entity_id: row.end.composition_entity_id})
MERGE (start)-[r:HAS_COMPOSITION_RELATION_OBJECT]->(end) SET r += row.properties;
UNWIND [{start: {composition_id:"composition-billiard-ball"}, end: {composition_group_id:"group-bb-billiard-ball"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_group_id:"group-bb-text"}, properties:{}}] AS row
MATCH (start:Composition{composition_id: row.start.composition_id})
MATCH (end:CompositionGroup{composition_group_id: row.end.composition_group_id})
MERGE (start)-[r:HAS_COMPOSITION_GROUP]->(end) SET r += row.properties;
UNWIND [{start: {concept_id:"concept-holding"}, end: {concept_id:"concept-handling"}, properties:{}}] AS row
MATCH (start:Concept{concept_id: row.start.concept_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IS_A]->(end) SET r += row.properties;
UNWIND [{start: {composition_entity_id:"entity-bb-billiard-ball-sphere"}, end: {composition_group_id:"group-bb-billiard-ball"}, properties:{}}, {start: {composition_entity_id:"entity-bb-circle"}, end: {composition_group_id:"group-bb-billiard-ball"}, properties:{}}, {start: {composition_entity_id:"entity-bb-glyph"}, end: {composition_group_id:"group-bb-text"}, properties:{}}, {start: {composition_entity_id:"entity-bb-glyph"}, end: {composition_group_id:"group-bb-billiard-ball"}, properties:{}}] AS row
MATCH (start:CompositionEntity{composition_entity_id: row.start.composition_entity_id})
MATCH (end:CompositionGroup{composition_group_id: row.end.composition_group_id})
MERGE (start)-[r:IS_PART_OF_COMPOSITION_GROUP]->(end) SET r += row.properties;
UNWIND [{start: {composition_pattern_id:"pattern-at-human-holding-object"}, end: {interpretation_id:"interpretation-at-human-holding-object"}, properties:{}}, {start: {composition_pattern_id:"pattern-bb-humand-holding-object"}, end: {interpretation_id:"interpretation-bb-human-holding-object"}, properties:{}}] AS row
MATCH (start:CompositionPattern{composition_pattern_id: row.start.composition_pattern_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_RECOGNITION]->(end) SET r += row.properties;
UNWIND [{start: {pattern_relation_id:"relation-holding"}, end: {pattern_entity_id:"entity-object"}, properties:{}}] AS row
MATCH (start:PatternRelation{pattern_relation_id: row.start.pattern_relation_id})
MATCH (end:PatternEntity{pattern_entity_id: row.end.pattern_entity_id})
MERGE (start)-[r:HAS_PATTERN_RELATION_OBJECT]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-human-holding-object"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-at-human-holding-object"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {reading_id:"reading-bb-7"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Reading{reading_id: row.start.reading_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:ACCEPTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_modifier_id:"modifier-at-using-right-hand"}, end: {interpretation_id:"interpretation-at-using-right-hand"}, properties:{}}, {start: {composition_modifier_id:"modifier-bb-using-right-hand"}, end: {interpretation_id:"interpretation-bb-using-right-hand"}, properties:{}}] AS row
MATCH (start:CompositionModifier{composition_modifier_id: row.start.composition_modifier_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_INTERPRETATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-tomato"}, end: {concept_id:"concept-tomato"}, properties:{}}, {start: {interpretation_id:"interpretation-at-apple"}, end: {concept_id:"concept-apple"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-human"}, end: {concept_id:"concept-human"}, properties:{}}, {start: {interpretation_id:"interpretation-at-human"}, end: {concept_id:"concept-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-sphere"}, end: {concept_id:"concept-sphere"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-l"}, end: {concept_id:"concept-letter-l"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-7"}, end: {concept_id:"concept-digit-7"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-circle"}, end: {concept_id:"concept-bb-circle"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {composition_group_id:"group-bb-text"}, end: {reading_id:"reading-bb-7"}, properties:{}}, {start: {composition_group_id:"group-bb-text"}, end: {reading_id:"reading-bb-l"}, properties:{}}] AS row
MATCH (start:CompositionGroup{composition_group_id: row.start.composition_group_id})
MATCH (end:Reading{reading_id: row.end.reading_id})
MERGE (start)-[r:HAS_READING]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-human-visual-scope"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-circle-color"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-sphere-color"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-color"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:ACCEPTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-presentation"}, end: {concept_id:"concept-presentation"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-presentation"}, end: {concept_id:"concept-presentation"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-presentation"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-presentation"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_parallel_id:"parallel-at-bb"}, end: {architectonic_id:"architectonic-compositional-parallel"}, properties:{}}] AS row
MATCH (start:CompositionParallel{composition_parallel_id: row.start.composition_parallel_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:HAS_PARALLEL_TYPE]->(end) SET r += row.properties;
UNWIND [{start: {composition_id:"composition-apple-tomato"}, end: {composition_comparison_id:"comparison-at"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_comparison_id:"comparison-bb"}, properties:{}}] AS row
MATCH (start:Composition{composition_id: row.start.composition_id})
MATCH (end:CompositionComparison{composition_comparison_id: row.end.composition_comparison_id})
MERGE (start)-[r:HAS_COMPOSITION_COMPARISON]->(end) SET r += row.properties;
UNWIND [{start: {concept_id:"concept-presentation"}, end: {concept_id:"concept-display"}, properties:{}}] AS row
MATCH (start:Concept{concept_id: row.start.concept_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IS_A]->(end) SET r += row.properties;
UNWIND [{start: {composition_id:"composition-apple-tomato"}, end: {composition_context_id:"context-at-functional-demo"}, properties:{}}, {start: {composition_id:"composition-billiard-ball"}, end: {composition_context_id:"context-bb-functional-demo"}, properties:{}}] AS row
MATCH (start:Composition{composition_id: row.start.composition_id})
MATCH (end:CompositionContext{composition_context_id: row.end.composition_context_id})
MERGE (start)-[r:HAS_COMPOSITION_CONTEXT]->(end) SET r += row.properties;
UNWIND [{start: {concept_id:"concept-tomato"}, end: {concept_id:"concept-fruit"}, properties:{}}, {start: {concept_id:"concept-apple"}, end: {concept_id:"concept-fruit"}, properties:{}}, {start: {concept_id:"concept-fruit"}, end: {concept_id:"concept-object"}, properties:{}}, {start: {concept_id:"concept-human"}, end: {concept_id:"concept-figure"}, properties:{}}, {start: {concept_id:"concept-digit-7"}, end: {concept_id:"concept-digit"}, properties:{}}, {start: {concept_id:"concept-digit"}, end: {concept_id:"concept-graphic-character"}, properties:{}}, {start: {concept_id:"concept-letter"}, end: {concept_id:"concept-graphic-character"}, properties:{}}, {start: {concept_id:"concept-letter-l"}, end: {concept_id:"concept-letter"}, properties:{}}, {start: {concept_id:"concept-bb-circle"}, end: {concept_id:"concept-bb-geometric-shape"}, properties:{}}, {start: {concept_id:"concept-sphere"}, end: {concept_id:"concept-bb-geometric-shape"}, properties:{}}, {start: {concept_id:"concept-bb-geometric-shape"}, end: {concept_id:"concept-shape"}, properties:{}}, {start: {concept_id:"concept-billiard-ball-7"}, end: {concept_id:"concept-billiard-ball"}, properties:{}}, {start: {concept_id:"concept-billiard-ball"}, end: {concept_id:"concept-sports-equipment"}, properties:{}}, {start: {concept_id:"concept-sports-equipment"}, end: {concept_id:"concept-object"}, properties:{}}] AS row
MATCH (start:Concept{concept_id: row.start.concept_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IS_A]->(end) SET r += row.properties;
UNWIND [{start: {composition_feature_id:"feature-at-apple-color"}, end: {interpretation_id:"interpretation-at-apple-color"}, properties:{}}, {start: {composition_feature_id:"feature-at-human-visual-scope"}, end: {interpretation_id:"interpretation-at-human-visual-scope"}, properties:{}}, {start: {composition_feature_id:"feature-bb-sphere-color"}, end: {interpretation_id:"interpretation-bb-sphere-color"}, properties:{}}, {start: {composition_feature_id:"feature-bb-human-visual-scope"}, end: {interpretation_id:"interpretation-bb-human-visual-scope"}, properties:{}}, {start: {composition_feature_id:"feature-bb-glyph-color"}, end: {interpretation_id:"interpretation-bb-glyph-color"}, properties:{}}, {start: {composition_feature_id:"feature-bb-circle-color"}, end: {interpretation_id:"interpretation-bb-circle-color"}, properties:{}}, {start: {composition_feature_id:"feature-bb-glyph-case"}, end: {interpretation_id:"interpretation-bb-glyph-case"}, properties:{}}] AS row
MATCH (start:CompositionFeature{composition_feature_id: row.start.composition_feature_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_INTERPRETATION]->(end) SET r += row.properties;
UNWIND [{start: {source_reference_id:"reference-at-apple-conflicting"}, end: {architectonic_id:"architectonic-conflicting"}, properties:{}}, {start: {source_reference_id:"reference-at-apple-concurring"}, end: {architectonic_id:"architectonic-concurring"}, properties:{}}] AS row
MATCH (start:SourceReference{source_reference_id: row.start.source_reference_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:HAS_EVIDENTIARY_RELATIONSHIP]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-glyph-l"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-7"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-human"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-sphere"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-circle"}, end: {agent_id:"agent-ai"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-using-right-hand"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:ACCEPTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-glyph-l"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:REJECTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_event_id:"event-at-presentation"}, end: {interpretation_id:"interpretation-at-presentation"}, properties:{}}, {start: {composition_event_id:"event-bb-presentation"}, end: {interpretation_id:"interpretation-bb-presentation"}, properties:{}}] AS row
MATCH (start:CompositionEvent{composition_event_id: row.start.composition_event_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_INTERPRETATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-billiard-ball"}, end: {concept_id:"concept-billiard-ball-7"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {reading_id:"reading-bb-l"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Reading{reading_id: row.start.reading_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:REJECTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-glyph-case"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:REJECTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-presentation"}, end: {architectonic_id:"architectonic-logical-deduction"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-presentation"}, end: {architectonic_id:"architectonic-logical-deduction"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:SUPPORTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_context_id:"context-at-functional-demo"}, end: {interpretation_id:"interpretation-at-functional-demo"}, properties:{}}, {start: {composition_context_id:"context-bb-functional-demo"}, end: {interpretation_id:"interpretation-bb-functional-demo"}, properties:{}}] AS row
MATCH (start:CompositionContext{composition_context_id: row.start.composition_context_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:HAS_INTERPRETATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-functional-demo"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-at-functional-demo"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {concept_id:"concept-using-right-hand"}, end: {concept_id:"concept-using-hand"}, properties:{}}] AS row
MATCH (start:Concept{concept_id: row.start.concept_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IS_A]->(end) SET r += row.properties;
UNWIND [{start: {pattern_entity_id:"entity-human"}, end: {pattern_relation_id:"relation-holding"}, properties:{}}] AS row
MATCH (start:PatternEntity{pattern_entity_id: row.start.pattern_entity_id})
MATCH (end:PatternRelation{pattern_relation_id: row.end.pattern_relation_id})
MERGE (start)-[r:HAS_PATTERN_RELATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-using-right-hand"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_relation_id:"relation-at-holding"}, end: {composition_modifier_id:"modifier-at-using-right-hand"}, properties:{}}, {start: {composition_relation_id:"relation-bb-holding"}, end: {composition_modifier_id:"modifier-bb-using-right-hand"}, properties:{}}] AS row
MATCH (start:CompositionRelation{composition_relation_id: row.start.composition_relation_id})
MATCH (end:CompositionModifier{composition_modifier_id: row.end.composition_modifier_id})
MERGE (start)-[r:HAS_COMPOSITION_MODIFIER]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-using-right-hand"}, end: {concept_id:"concept-using-right-hand"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-using-right-hand"}, end: {concept_id:"concept-using-right-hand"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-glyph-case"}, end: {interpretation_id:"interpretation-bb-glyph-l"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Interpretation{interpretation_id: row.end.interpretation_id})
MERGE (start)-[r:DEPENDS_ON]->(end) SET r += row.properties;
UNWIND [{start: {composition_entity_id:"entity-at-human"}, end: {composition_relation_id:"relation-at-holding"}, properties:{}}, {start: {composition_entity_id:"entity-bb-human"}, end: {composition_relation_id:"relation-bb-holding"}, properties:{}}] AS row
MATCH (start:CompositionEntity{composition_entity_id: row.start.composition_entity_id})
MATCH (end:CompositionRelation{composition_relation_id: row.end.composition_relation_id})
MERGE (start)-[r:HAS_COMPOSITION_RELATION]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-apple"}, end: {architectonic_id:"architectonic-missing-attribute"}, properties:{}}, {start: {interpretation_id:"interpretation-at-apple"}, end: {architectonic_id:"architectonic-ambiguity"}, properties:{}}, {start: {interpretation_id:"interpretation-at-tomato"}, end: {architectonic_id:"architectonic-ambiguity"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-l"}, end: {architectonic_id:"architectonic-ambiguity"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-7"}, end: {architectonic_id:"architectonic-ambiguity"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:IMPAIRED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_comparison_id:"comparison-at"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {composition_comparison_id:"comparison-bb"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:CompositionComparison{composition_comparison_id: row.start.composition_comparison_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-apple-color"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-at-human-visual-scope"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-human-holding-object"}, end: {pattern_id:"pattern-human-holding-object"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-human-holding-object"}, end: {pattern_id:"pattern-human-holding-object"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Pattern{pattern_id: row.end.pattern_id})
MERGE (start)-[r:RECOGNIZED_PATTERN]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-functional-demo"}, end: {concept_id:"concept-functional-demo"}, properties:{}}, {start: {interpretation_id:"interpretation-at-functional-demo"}, end: {concept_id:"concept-functional-demo"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {composition_entity_id:"entity-at-apple-tomato"}, end: {composition_feature_id:"feature-at-apple-color"}, properties:{}}, {start: {composition_entity_id:"entity-at-human"}, end: {composition_feature_id:"feature-at-human-visual-scope"}, properties:{}}, {start: {composition_entity_id:"entity-bb-billiard-ball-sphere"}, end: {composition_feature_id:"feature-bb-sphere-color"}, properties:{}}, {start: {composition_entity_id:"entity-bb-human"}, end: {composition_feature_id:"feature-bb-human-visual-scope"}, properties:{}}, {start: {composition_entity_id:"entity-bb-glyph"}, end: {composition_feature_id:"feature-bb-glyph-color"}, properties:{}}, {start: {composition_entity_id:"entity-bb-circle"}, end: {composition_feature_id:"feature-bb-circle-color"}, properties:{}}, {start: {composition_entity_id:"entity-bb-glyph"}, end: {composition_feature_id:"feature-bb-glyph-case"}, properties:{}}] AS row
MATCH (start:CompositionEntity{composition_entity_id: row.start.composition_entity_id})
MATCH (end:CompositionFeature{composition_feature_id: row.end.composition_feature_id})
MERGE (start)-[r:HAS_COMPOSITION_FEATURE]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-holding"}, end: {concept_id:"concept-holding"}, properties:{}}, {start: {interpretation_id:"interpretation-at-holding"}, end: {concept_id:"concept-holding"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IDENTIFIED_AS_CONCEPT]->(end) SET r += row.properties;
UNWIND [{start: {source_reference_id:"reference-bb-billiard-ball-concurring"}, end: {architectonic_id:"architectonic-concurring"}, properties:{}}] AS row
MATCH (start:SourceReference{source_reference_id: row.start.source_reference_id})
MATCH (end:Architectonic{architectonic_id: row.end.architectonic_id})
MERGE (start)-[r:HAS_EVIDENTIARY_RELATIONSHIP]->(end) SET r += row.properties;
UNWIND [{start: {pattern_id:"pattern-human-holding-object"}, end: {pattern_entity_id:"entity-object"}, properties:{}}, {start: {pattern_id:"pattern-human-holding-object"}, end: {pattern_entity_id:"entity-human"}, properties:{}}] AS row
MATCH (start:Pattern{pattern_id: row.start.pattern_id})
MATCH (end:PatternEntity{pattern_entity_id: row.end.pattern_entity_id})
MERGE (start)-[r:HAS_PATTERN_ENTITY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-glyph-case"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-human-visual-scope"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-sphere-color"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-circle-color"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-glyph-color"}, end: {agent_id:"agent-ai"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-glyph-7"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-human"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-sphere"}, end: {agent_id:"agent-human"}, properties:{}}, {start: {interpretation_id:"interpretation-bb-circle"}, end: {agent_id:"agent-human"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:ACCEPTED_BY]->(end) SET r += row.properties;
UNWIND [{start: {composition_comparison_id:"comparison-at"}, end: {composition_parallel_id:"parallel-at-bb"}, properties:{}}, {start: {composition_comparison_id:"comparison-bb"}, end: {composition_parallel_id:"parallel-at-bb"}, properties:{}}] AS row
MATCH (start:CompositionComparison{composition_comparison_id: row.start.composition_comparison_id})
MATCH (end:CompositionParallel{composition_parallel_id: row.end.composition_parallel_id})
MERGE (start)-[r:ASSERTED]->(end) SET r += row.properties;
UNWIND [{start: {concept_id:"concept-detail-hand"}, end: {concept_id:"concept-human-visual-scope"}, properties:{}}, {start: {concept_id:"concept-human-visual-scope"}, end: {concept_id:"concept-visual-scope"}, properties:{}}, {start: {concept_id:"concept-white"}, end: {concept_id:"concept-color"}, properties:{}}, {start: {concept_id:"concept-black"}, end: {concept_id:"concept-color"}, properties:{}}, {start: {concept_id:"concept-uppercase"}, end: {concept_id:"concept-case"}, properties:{}}, {start: {concept_id:"concept-case"}, end: {concept_id:"concept-typographic-attribute"}, properties:{}}, {start: {concept_id:"concept-red"}, end: {concept_id:"concept-color"}, properties:{}}] AS row
MATCH (start:Concept{concept_id: row.start.concept_id})
MATCH (end:Concept{concept_id: row.end.concept_id})
MERGE (start)-[r:IS_A]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-bb-holding"}, end: {agent_id:"agent-ai"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
UNWIND [{start: {interpretation_id:"interpretation-at-apple"}, end: {source_reference_id:"reference-at-apple-conflicting"}, properties:{}}, {start: {interpretation_id:"interpretation-at-apple"}, end: {source_reference_id:"reference-at-apple-concurring"}, properties:{}}, {start: {interpretation_id:"interpretation-billiard-ball"}, end: {source_reference_id:"reference-bb-billiard-ball-concurring"}, properties:{}}] AS row
MATCH (start:Interpretation{interpretation_id: row.start.interpretation_id})
MATCH (end:SourceReference{source_reference_id: row.end.source_reference_id})
MERGE (start)-[r:HAS_SOURCE_REFERENCE]->(end) SET r += row.properties;
UNWIND [{start: {composition_relation_id:"relation-at-holding"}, end: {composition_event_id:"event-at-presentation"}, properties:{}}, {start: {composition_relation_id:"relation-bb-holding"}, end: {composition_event_id:"event-bb-presentation"}, properties:{}}] AS row
MATCH (start:CompositionRelation{composition_relation_id: row.start.composition_relation_id})
MATCH (end:CompositionEvent{composition_event_id: row.end.composition_event_id})
MERGE (start)-[r:HAS_COMPOSITION_EVENT]->(end) SET r += row.properties;
UNWIND [{start: {reading_id:"reading-bb-7"}, end: {agent_id:"agent-ai"}, properties:{}}, {start: {reading_id:"reading-bb-l"}, end: {agent_id:"agent-ai"}, properties:{}}] AS row
MATCH (start:Reading{reading_id: row.start.reading_id})
MATCH (end:Agent{agent_id: row.end.agent_id})
MERGE (start)-[r:STATED_BY]->(end) SET r += row.properties;
:commit
