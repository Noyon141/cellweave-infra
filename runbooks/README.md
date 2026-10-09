# CellWeave Operational Runbooks & Incident Response

This directory contains the mandatory operational runbooks required prior to production launch in accordance with `CellWeave Production Master System Design v1.0` Section 126 & 127.

## Incident Severity Levels
- **SEV-1 (Critical):** Cross-tenant data exposure, major customer data loss, or primary security compromise. *Automatically activates security incident protocol.*
- **SEV-2 (Major):** Major scientific analysis outage, widespread workflow execution block, or critical billing corruption.
- **SEV-3 (Moderate):** Degraded feature, isolated scientific workflow failure patterns, or non-critical provider sync lag.
- **SEV-4 (Minor):** Non-blocking cosmetic defect or low-impact query issue.

## Runbook Mandatory Sections
Every runbook adheres to the required incident structure:
1. Detection Signals
2. Severity Classification
3. Owner
4. Immediate Containment
5. Recovery Procedure
6. Validation of Recovery
7. Customer Communication Criteria
8. Evidence Preservation
9. Postmortem Requirements

## Runbooks Index
- [`database-outage.md`](./database-outage.md)
- [`r2-outage.md`](./r2-outage.md)
- [`temporal-outage.md`](./temporal-outage.md)
- [`modal-outage.md`](./modal-outage.md)
- [`polar-outage.md`](./polar-outage.md)
- [`oauth-outage.md`](./oauth-outage.md)
- [`run-stuck.md`](./run-stuck.md)
- [`billing-mismatch.md`](./billing-mismatch.md)
- [`customer-data-deletion.md`](./customer-data-deletion.md)
- [`credential-compromise.md`](./credential-compromise.md)
- [`cross-tenant-access-incident.md`](./cross-tenant-access-incident.md)
- [`pipeline-scientific-regression.md`](./pipeline-scientific-regression.md)
- [`bad-deployment-rollback.md`](./bad-deployment-rollback.md)
