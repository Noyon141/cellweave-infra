---
name: change-infrastructure
description: Changes CellWeave infrastructure while preserving deployment boundaries, environment isolation, least privilege, observability, DR, and no-premature-Kubernetes constraints.
---

# Change Infrastructure

1. Trace the requested change to the authoritative design.
2. Confirm it belongs in `cellweave-infra`.
3. Identify affected environments and keep them isolated.
4. Preserve web/database/storage/orchestration/compute boundaries.
5. Use least-privilege service identities and separate secrets.
6. Preserve private R2 and scoped access.
7. Add/adjust telemetry and provider-health detection.
8. Identify backup/DR impact.
9. Identify CI/CD evidence and rollback behavior.
10. Do not introduce Kubernetes or unselected vendors merely for convenience.
11. Test in development/staging shape before production.
12. Update deployment/runbook/security documentation.
