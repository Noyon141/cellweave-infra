# Runbook: Neon Database Outage

## 1. Detection Signals
- Neon compute endpoint health check failures (`pg_isready` returns exit code 2).
- HTTP 500 error spike on Next.js database queries with connection timeout errors (`ECONNREFUSED` / `ETIMEDOUT`).
- Alert `DatabaseConnectionExhaustion` fires.

## 2. Severity Classification
- **SEV-2** (Standard platform unavailability).
- Escalates to **SEV-1** if accompanied by storage corruption or unrecoverable data loss.

## 3. Owner
Infrastructure Lead / On-Call Site Reliability Engineer.

## 4. Immediate Containment
1. Check Neon status page (`status.neon.tech`).
2. If Neon compute endpoint is suspended or unresponsive, trigger compute endpoint restart via Neon Console or Neon CLI:
   `neonctl endpoints restart --project-id <project_id> <endpoint_id>`.
3. If connection pool is exhausted by rogue queries, terminate idle transactions:
   `SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE state = 'idle in transaction' AND state_change < now() - INTERVAL '5 minutes';`.

## 5. Recovery
1. If compute instance fails to recover, activate Neon Point-in-Time Recovery (PITR) branch from 5 minutes prior to outage.
2. Update application `DATABASE_URL` to point to the recovered branch endpoint.
3. Restart web serverless pools and Temporal Worker connections.

## 6. Validation of Recovery
1. Run smoke query: `SELECT count(*) FROM organizations;`.
2. Verify Next.js `/api/health` returns HTTP 200 with DB check passing.
3. Confirm Temporal worker reconnects and resumes workflow step projections.

## 7. Customer Communication Criteria
- Update public status page within 15 minutes of downtime.
- Notify active organization administrators if downtime exceeds 30 minutes.

## 8. Evidence Preservation
- Export Neon query performance logs and PostgreSQL error logs from the incident window.
- Preserve Sentry error snapshots and APM connection pool metrics.

## 9. Postmortem Requirements
- Blameless postmortem published within 48 hours documenting root cause, RTO achieved vs 4-hour target, and connection pool tuning actions.
