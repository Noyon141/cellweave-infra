# ADR-0009: Separate Repositories Architecture

## Status
Accepted (Authoritative Baseline)

## Context
A unified monolithic repository often leads to boundary erosion between the SaaS application layer, orchestration workers, and Python scientific environments. This frequently manifests in scientific libraries leaking into Next.js bundles, database admin credentials being shared with scientific worker containers, or workflow orchestration being coupled to HTTP request lifecycles.

## Decision
CellWeave enforces a five-repository architecture:
1. `cellweave-web`: Next.js web application, UI, BetterAuth, customer API, Drizzle/Neon database access, and Polar webhooks.
2. `cellweave-orchestrator`: Always-on TypeScript Temporal Worker, workflow definitions, activities, retry policies, and `ComputeProvider` adapters. Exposes no customer HTTP API.
3. `cellweave-science`: Python scientific engine, Scanpy/scvi-tools algorithms, golden datasets, and Modal entrypoints. Contains no SaaS business logic.
4. `cellweave-contracts`: Source-of-truth OpenAPI, JSON Schema, and event schemas. Generates TypeScript types and Python Pydantic models to prevent payload duplication.
5. `cellweave-infra`: Terraform/OpenTofu, environment definitions, Cloudflare R2, Temporal namespaces, CI templates, monitoring, security policies, and runbooks.

## Consequences
### Positive
- Strict physical separation of dependencies, runtime environments, and blast radiuses.
- Least-privilege credential separation (e.g. Science containers never receive DB credentials).
- Clear team and agent ownership boundaries.

### Negative / Trade-offs
- Requires coordinated schema versioning and contract generation across repositories via `cellweave-contracts`.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 10 ("Repository Architecture"), Section 165 ("Architecture Rule That Must Never Be Broken").
