# ADR-0007: Pseudobulk Condition Differential Expression

## Status
Accepted (Authoritative Baseline)

## Context
A prevalent pitfall in single-cell transcriptomics software is treating individual single cells as independent biological observations in condition-level comparisons (e.g., Disease vs Healthy or Drug vs Control). This practice artificially inflates sample size (treating 10,000 cells from 2 mice as N=10,000), producing astronomical false-positive rates and biologically spurious p-values.

## Decision
CellWeave establishes rigorous scientific boundaries for statistical testing:
1. Cell-level statistical tests (e.g. Wilcoxon) are permitted exclusively for cluster marker gene discovery.
2. Cross-condition experiment comparisons (e.g. Treatment vs Vehicle) must default toward sample-level / pseudobulk aggregation when biological replicates exist.
3. System validates experiment metadata: number of biological samples, condition assignments, biological replicates, batch structure, and cell counts.
4. If an experiment comparison has insufficient biological replicates or severe confounding, the system issues an explicit scientific warning and records it in immutable run provenance.

## Consequences
### Positive
- Prevents publication of scientifically invalid or unreplicable statistical conclusions.
- Establishes CellWeave as a credible, scientifically rigorous platform for professional bioinformatics teams.

### Negative / Trade-offs
- Requires bioinformaticians to provide structured sample/replicate metadata during experiment setup.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 28 ("Differential Expression"), Section 31 ("Experiment Comparison"), Section 116 ("Customer-Facing Scientific Warnings").
