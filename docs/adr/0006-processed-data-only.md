# ADR-0006: Processed-Data-Only Scientific Scope (V1)

## Status
Accepted (Authoritative Baseline)

## Context
Raw sequencing outputs (FASTQ files) require massive compute clusters, high disk throughput, and lengthy alignment and quantification pipelines (Cell Ranger, STAR-solo, Kallisto/Bustools). Supporting raw read processing would drastically inflate infrastructure costs, operational complexity, and regulatory exposure while delaying core product delivery for bioinformatics teams that already possess processed matrix outputs.

## Decision
CellWeave V1 starts strictly after primary sequencing processing:
1. FASTQ processing, read alignment, genome mapping, and UMI counting are explicit non-goals for V1.
2. Ingestion is restricted to processed outputs: 10x filtered matrices (`filtered_feature_bc_matrix.h5` and grouped MTX files), `.h5ad` files, and generic expression matrices with sample metadata.
3. System architecture avoids premature specialized high-throughput file systems (e.g. Lustre/EFS) in favor of object storage (R2).

## Consequences
### Positive
- Focused scope on downstream scientific exploration, cell typing, comparisons, and reproducibility.
- Bounded compute and storage footprints, enabling predictable SaaS economics.
- Simplified upload pathways via direct browser-to-R2 presigned multipart uploads.

### Negative / Trade-offs
- Customers must run primary alignment tools upstream before uploading to CellWeave.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 1 ("Product Definition"), Section 4 ("Explicit Non-Goals").
