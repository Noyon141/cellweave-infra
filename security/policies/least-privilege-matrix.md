# Least Privilege Permission Matrix

To prevent lateral movement and minimize blast radius, system components receive only the minimal credentials necessary to execute their assigned role.

## Component Permissions Matrix

| Component | Database (Postgres) | Storage (Cloudflare R2) | Orchestration (Temporal) | Compute (Modal) | Commercial Billing (Polar) |
|---|---|---|---|---|---|
| **Next.js Web / API** | Full Application schema access (`SELECT`, `INSERT`, `UPDATE`, `DELETE`) with `TenantContext` enforcement | Generates presigned upload & download URLs; no direct object stream proxying | Starts workflows (`START_PENDING`); sends signals (`confirmQC`, `cancel`) | None | Receives webhooks; syncs subscriptions; manages customer portal sessions |
| **Temporal Worker** | Projection updates, workflow state steps, `usage_ledger` inserts | None (delegates storage operations to Activities) | Polling and task execution on task queues | Dispatches compute jobs via `ComputeProvider` | None |
| **Modal Science Worker** | **NONE** (No database connection strings or credentials) | Reads specific input via presigned GET; writes specific output via presigned PUT | **NONE** | Pure algorithm runtime | **NONE** |
| **Operations Console** | Read-only operational tenant queries; break-glass required for escalated audit inspection | Generates audit download URLs if break-glass authorized | Can inspect execution history, cancel stuck runs, or trigger reconciliations | None | Inspects sync outbox and webhook failure logs |
| **Migration Runner (CI/CD)** | DDL / Schema migration authority (`CREATE`, `ALTER`, `DROP` within migrations) | None | None | None | None |
