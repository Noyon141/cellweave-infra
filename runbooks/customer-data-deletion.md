# Runbook: Customer Data Deletion & Organization Purge

## 1. Detection Signals
- Scheduled `data_deletion_jobs` task fails or enters `FAILED` status.
- Alert fires on stuck deletion job exceeding configured execution threshold.
- Customer Organization Owner requests organization deletion via settings.

## 2. Severity Classification
- **SEV-3** for individual job delays.
- **SEV-1** if deletion affects resources of a different tenant (cross-tenant contamination).

## 3. Owner
Security Lead / Infrastructure Lead.

## 4. Immediate Containment
1. If cross-tenant deletion risk is suspected, IMMEDIATELY halt the `data_deletion_jobs` background worker.
2. Verify deletion scope: Deletion queries MUST enforce strict `organizationId` scoping.

## 5. Recovery
1. Follow designed deletion lifecycle:
   `ACTIVE` -> `SOFT_DELETED` -> `RECOVERY_WINDOW` (configuration-defined / plan-governed grace period) -> `PURGE_PENDING` -> `PURGED`.
2. Ensure Organization Owner authentication, MFA confirmation, and confirmation token verification took place.
3. Execute phased purge worker:
   - Phase A: Delete R2 objects under `org/{orgId}/` prefix.
   - Phase B: Delete Postgres scientific records (`analysis_runs`, `datasets`, `samples`, `experiments`, `projects`, `comments`).
   - Phase C: Invalidate API tokens, sessions, and BetterAuth memberships.
   - Phase D: Retain minimized financial ledger rows only where required by statutory tax/accounting obligations.
4. Update `data_deletion_jobs` status to `PURGED`.

## 6. Validation of Recovery
1. Verify no R2 objects exist under `org/{targetOrgId}/`.
2. Verify zero active project/dataset records exist for `targetOrgId` in PostgreSQL.
3. Confirm adjacent tenant records remain 100% untouched.

## 7. Customer Communication Criteria
- Send confirmation of completed organization purge to Organization Owner upon purge completion.

## 8. Evidence Preservation
- Retain cryptographic audit log entry recording deletion execution time, actor ID, and purged object count.

## 9. Postmortem Requirements
- Audit deletion verification logs to ensure strict tenant boundaries were maintained throughout the process.
