# IN.IDEA: Known Issues and Limitations

This document tracks identified architectural inconsistencies, simplified data representations in the fixtures, and planned structural refinements for future releases.


## 1. Non-Exhaustive Fixture Annotation

* **Description:** The provided fixtures are for demonstration purposes only.
* **Impact:** They do not represent an exhaustive iconographical description of the objects. Many formal elements, features, or contexts that would be present in a production-level dataset are omitted to maintain focus on the Four-Layer Architecture.

## 2. Inconsistent Reading Lifecycle (The "Billiard Ball" Case)

* **Description:** In the provided fixtures, a `Reading` proposed by an `AIAgent` is rejected by a `HumanAgent` without further action to the remaining data.
* **Technical Debt:** In a production environment, the rejection of a reading should trigger:
  1. The rejected `Reading` should be marked as `Rejected` (done).
  2. The remaining valid `Reading` needs to be set to `Outdated`, because the `certainty` changes, but a `Reading` cannot be changed (frozen in time)
  3. A new "Primary" `Reading` should be generated with an updated (likely higher) `certainty` value replacing the outdated one.

* **Reasoning:** This step was omitted in the fixtures to simplify the visual representation of the graph in the Neo4j Browser for first-time users.

## 3. Modeling Competing Interpretations

* **Description:** While IN.IDEA allows for multiple `Interpretation` nodes, the explicit relationship between *competing* hypotheses is currently handled only via the `status` property ("Primary", "Alternative", "Rejected" etc.).
* **Planned Research:** We are monitoring whether the current "status-only" approach is sufficient or if a dedicated edge type (e.g., `CONFLICTS_WITH`) is required to explicitly link mutually exclusive interpretations.
* **Current Strategy:** To avoid "schema-less sprawl," we will observe this situation in controlled test cases before introducing new edge types to the IN.IDEA Core.

## 4. Normalization of Chromaticity

* **Description:** `Chromaticity` (e.g., polychromatic, monochromatic) is currently defined as a simple property of the `Composition` node.
* **Refinement:** Following graph normalization best practices, this attribute should likely be reified into its own node.
* **Open Question:** We are currently evaluating if chromaticity belongs within the **CompositionContext** layer or if it requires a dedicated node structure to better support queries regarding artistic techniques across different epochs.