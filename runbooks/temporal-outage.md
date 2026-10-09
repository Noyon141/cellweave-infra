# Runbook: Temporal Outage

## 1. Detection Signals
- Alert `OrchestratorWorkerDown` or `WorkflowDurabilityDrop` triggers.
- Next.js API returns errors when enqueueing new runs (`analysis_run.status = START_PENDING` fails to reach `QUEUED`).
- Temporal Web UI / Temporal Cloud API reports service disruption (`status.temporal.io`).

## 2. Severity Classification
- **SEV-2** (Workflow orchestration interruption).

## 3. Owner
Backend / Orchestration Lead.

## 4. Immediate Containment
1. Check Temporal Cloud status page.
2. In Next.js, verify that new runs continue to be safely persisted in Postgres as `START_PENDING`. Run creation consistency ensures no user requests are dropped.
3. If Temporal Worker crashes, check worker container logs for out-of-memory or fatal unhandled rejections.

## 5. Recovery
1. If Temporal Cloud experienced an outage: Wait for service restoration. Temporal's client SDKs will automatically reconnect.
2. If Worker process crashed: Restart worker service instances:
   Verify health with `docker ps` or platform CLI (e.g. `flyctl restart` / `ecs update-service`).
3. Run background reconciliation job:
   Reconciliation scans `analysis_runs` with `START_PENDING` older than 5 minutes and starts corresponding Temporal workflows using deterministic IDs `analysis-run:{id}`.

## 6. Validation of Recovery
1. Confirm Temporal Worker polling on task queues.
2. Verify all `START_PENDING` runs transition to `QUEUED` or `RUNNING`.
3. Verify test workflow completes end-to-end.

## 7. Customer Communication Criteria
- Notify affected users if running analysis workflows experience delayed completion beyond 1 hour.

## 8. Evidence Preservation
- Export Temporal execution history JSON for interrupted workflows.
- Retain worker application logs prior to the crash.

## 9. Postmortem Requirements
- Document time-to-reconciliation and ensure no duplicate analysis jobs were launched.
