# Internal Service Authentication & Scoped Credentials

## Architectural Standard
In accordance with `CellWeave Production Master System Design v1.0` Section 66:
Static, shared master API keys must NOT become the permanent inter-service architecture.

## Token Characteristics
All internal service-to-service calls (e.g. Orchestrator Worker -> Next.js Internal API, Webhook dispatch) use short-lived signed service credentials containing:
- `iss` (Issuer): Verified service identity (e.g., `cellweave-orchestrator-worker`)
- `aud` (Audience): Target subsystem (e.g., `cellweave-internal-api`)
- `sub` (Subject): Workload or task context
- `scope`: Granular permissions (e.g., `workflow:update_step`, `usage:report`)
- `exp` (Expiration): Maximum TTL <= 15 minutes

## Compute Worker Isolation
Science workers running on Modal are isolated from the internal network:
1. Modal containers NEVER receive service tokens with database access.
2. Modal containers receive only signed URLs scoped to specific object keys in R2 for input reading and output writing.
