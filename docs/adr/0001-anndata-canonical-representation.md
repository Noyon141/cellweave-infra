# ADR-0001: AnnData Canonical Internal Representation

## Status
Accepted (Authoritative Baseline)

## Context
CellWeave receives heterogeneous processed inputs from various single-cell protocols and vendors, including `.h5ad`, 10x Genomics filtered matrices (`filtered_feature_bc_matrix.h5` and grouped MTX/TSV), and generic CSV/TSV expression matrices. Without a standardized internal representation, every downstream scientific step (QC, filtering, normalization, PCA, UMAP, clustering, annotation, marker finding, differential expression) would require vendor-specific handling, leading to pipeline drift and maintenance combinatorial explosion.

## Decision
All supported input formats must convert into a canonical AnnData representation (`canonical.h5ad`) during the validation and import phase. All downstream analytical steps and workflows operate exclusively on this canonical AnnData representation. Future format additions (such as cloud-native Zarr) remain an enum extension (`H5AD | ZARR`), preserving the AnnData conceptual data model.

## Consequences
### Positive
- Strict isolation of vendor ingestion logic from analysis logic.
- Standardized access to expression matrices `X`, observations `obs`, variables `var`, and multidimensional layers.
- Seamless compatibility with the Python scverse ecosystem (Scanpy, scvi-tools, Scrublet).

### Negative / Trade-offs
- Conversion step incurs initial compute and temporary storage overhead during ingest.
- Large AnnData objects must be chunked or streamed into visualization artifacts rather than loaded raw in client browsers.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 1, Section 18 ("Canonical Scientific Representation").
