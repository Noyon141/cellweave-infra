# Runbook: Pipeline Scientific Regression

## 1. Detection Signals
- Scientific regression benchmark suite fails during release qualification.
- Golden dataset benchmark divergence: unexpected drop in marker gene recovery (> 10%), altered cell-type annotation confidence, or inverted differential expression fold-changes.
- Customer reporting unexpected biological divergence after pipeline upgrade.

## 2. Severity Classification
- **SEV-2** if affecting production pipelines or default releases; **SEV-3** if detected in staging qualification.

## 3. Owner
Lead Bioinformatician / Scientific Platform Lead.

## 4. Immediate Containment
1. In accordance with Section 103, pipeline versions are strictly immutable. Block new runs from utilizing the regressed pipeline version.
2. Pin new analysis default back to the previous validated pipeline version (e.g., revert default pointer from `1.4.0` back to `1.3.0`).
3. Note: Existing completed analyses remain pinned to their historical pipeline versions and must NEVER be retroactively recomputed in-place.

## 5. Recovery
1. Pull golden benchmark datasets (10k PBMC, mouse brain, multi-sample batch dataset).
2. Isolate regression to algorithm parameter change, underlying package upgrade (Scanpy / SciPy / scvi-tools version bump), or random seed non-determinism.
3. Formulate fix and execute complete golden dataset regression test suite:
   `pytest tests/regression/golden_datasets`.
4. Release patched pipeline under a new immutable version identifier (e.g. `1.4.1`).

## 6. Validation of Recovery
1. Validate that all 7 golden benchmarks pass scientific tolerance thresholds.
2. Verify deterministic execution across multiple runs with pinned random seeds.

## 7. Customer Communication Criteria
- If customer runs completed with a regressed pipeline version, notify affected scientists with detailed scientific errata and offer automated re-run under the corrected pipeline version.

## 8. Evidence Preservation
- Archive regressed run manifests, benchmark metric comparisons, and software environment dependency locks.

## 9. Postmortem Requirements
- Document root cause (e.g., upstream library numerical drift) and expand golden dataset test coverage.
