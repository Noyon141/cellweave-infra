---
trigger: always_on
description: "Requires the CellWeave production runbooks, severity model, containment/recovery structure, and security incident escalation."
---

# Runbooks / Incidents

Required pre-launch runbooks:
- database outage
- R2 outage
- Temporal outage
- Modal outage
- Polar outage
- OAuth outage
- stuck run
- billing mismatch
- customer data deletion
- credential compromise
- cross-tenant access incident
- pipeline scientific regression
- bad deployment rollback

Each defines:
detection, severity, owner, containment, recovery, customer communication, postmortem.

Severity:
SEV-1: cross-tenant exposure, major data loss, security compromise.
SEV-2: major analysis outage, billing corruption.
SEV-3: degraded feature, workflow failure pattern.
SEV-4: minor defect.

SEV-1 automatically triggers security incident procedure.

Do not access scientific raw content by default for support diagnostics.
