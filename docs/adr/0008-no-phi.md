# ADR-0008: Prohibition of Protected Health Information (No PHI)

## Status
Accepted (Authoritative Baseline)

## Context
CellWeave is positioned as a Research Use Only (RUO), non-diagnostic scientific platform for biotech discovery and CRO research. Handling Protected Health Information (PHI) under HIPAA imposes extensive compliance, auditing, business associate agreement (BAA), and infrastructure encryption constraints that are unnecessary for preclinical single-cell research and out of scope for V1.

## Decision
CellWeave strictly prohibits the upload, storage, and processing of Protected Health Information:
1. Product terms, onboarding, and UI upload interfaces must prominently declare: "Research Use Only; Non-diagnostic; PHI prohibited".
2. Only de-identified research datasets with anonymized sample keys are permitted.
3. Metadata inspection routines validate and reject common direct patient identifiers.
4. Support diagnostics, central logs, and telemetry must never record or expose gene matrices, raw biological measurements, or sensitive filenames.

## Consequences
### Positive
- Minimizes regulatory and compliance overhead for initial commercial launch.
- Focuses engineering effort on scientific capabilities, workflow durability, and multi-tenant security.

### Negative / Trade-offs
- Clinical diagnostics workflows and direct hospital patient management are prohibited.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 1 ("Product Definition"), Section 4 ("Explicit Non-Goals"), Section 88 ("Research-Use-Only Boundary").
