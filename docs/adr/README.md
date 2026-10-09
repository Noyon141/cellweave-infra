# Architecture Decision Records (ADRs)

This directory maintains the immutable architectural decisions for CellWeave in accordance with `CellWeave Production Master System Design v1.0`.

## Discipline & Rules

1. Baseline decisions are derived directly from the authoritative system design.
2. An agent-generated ADR cannot silently override or weaken the authoritative system design.
3. Modifying a baseline architectural decision is not a routine refactor; it requires explicit architectural review.
4. All ADRs use the format defined in [`0000-template.md`](./0000-template.md).

## Baseline ADR Index

- [ADR-0001: AnnData Canonical Representation](./0001-anndata-canonical-representation.md)
- [ADR-0002: Cloudflare R2 Object Storage](./0002-r2-storage.md)
- [ADR-0003: Temporal Durable Workflows](./0003-temporal-durable-workflows.md)
- [ADR-0004: Modal Initial Compute Provider](./0004-modal-initial-compute-provider.md)
- [ADR-0005: Polar Billing Integration](./0005-polar-billing.md)
- [ADR-0006: Processed Data Only Scope](./0006-processed-data-only.md)
- [ADR-0007: Pseudobulk Condition Differential Expression](./0007-pseudobulk-condition-de.md)
- [ADR-0008: Prohibition of Protected Health Information (No PHI)](./0008-no-phi.md)
- [ADR-0009: Separate Repositories Architecture](./0009-separate-repositories.md)
