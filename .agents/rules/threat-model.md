---
trigger: always_on
description: "Maps CellWeave's documented threats to required mitigation classes and production controls."
---

# Threat Model

Threat → mitigation:
- cross-tenant IDOR → TenantContext + authorization + tests + optional RLS
- public scientific files → private R2 + short-lived signed URLs
- malicious archive → sandboxed extraction + limits
- worker compromise → scoped URLs; no DB credentials
- duplicate workflow → deterministic Temporal workflow ids
- duplicate billing → immutable usage ids
- webhook replay → signature + external-event uniqueness
- privilege escalation → explicit RBAC
- compute abuse → quotas + resource ceilings
- secret leak → isolated secret stores
- dependency compromise → lockfiles + SBOM + scanning
- silent scientific regression → benchmark/golden dataset gates

Infrastructure changes must not weaken these controls.
