# ADR-0004: Modal Initial Scientific Compute Provider

## Status
Accepted (Authoritative Baseline)

## Context
Scientific pipeline steps have wildly varying resource demands: fast lightweight CPU statistics (QC, marker calculation) versus high-memory CPU operations (graph construction) versus specialized GPU workloads (scVI/scANVI deep learning models). Managing a dedicated Kubernetes cluster in early stages introduces excessive operational overhead, high idle infrastructure costs, and complex scaling machinery.

## Decision
Modal is selected as the initial elastic scientific compute platform for CPU and GPU workloads:
1. Workloads are dispatched dynamically with containerized environments matching resource profiles (`CPU_SMALL`, `CPU_MEMORY`, `CPU_HIGH_MEMORY`, `GPU_SMALL`, `GPU_LARGE`).
2. Temporal Workers interface with Modal exclusively through a generic `ComputeProvider` TypeScript abstraction (`submit()`, `status()`, `cancel()`, `result()`).
3. No domain logic or web services may directly invoke Modal.
4. Kubernetes is explicitly prohibited in early stages; future transitions to AWS Batch, ECS/Fargate, or dedicated compute are handled via the `ComputeProvider` interface without architectural refactoring.

## Consequences
### Positive
- Sub-second serverless cold starts for containerized Python scientific runtimes.
- True pay-per-second elastic scaling with zero idle compute cost.
- Support for on-demand GPU instances without cluster administration.

### Negative / Trade-offs
- Vendor dependency on Modal's platform availability; mitigated by the strict `ComputeProvider` abstraction and classified retry strategies.
- Enforced compute ceilings and resource estimation must be strictly validated before job dispatch to prevent cost runaway.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 9, Section 10, Section 42-45 ("Compute Architecture & Provider Abstraction"), Section 130 ("Scalability Model - Stage 1"), Section 165.
