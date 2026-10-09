# Runbook: Stuck Scientific Analysis Run

## 1. Detection Signals
- Analysis run remains in `RUNNING` or `QUEUED` state longer than maximum expected pipeline duration (e.g., > 4 hours).
- Customer reports run showing perpetual spinning indicator on dashboard.
- Workflow execution in Temporal Cloud shows an activity blocked on infinite retry or heartbeat timeout.

## 2. Severity Classification
- **SEV-3** (Isolated run degradation) or **SEV-2** if affecting a cluster of customer runs.

## 3. Owner
On-Call Engineer / Bioinformatics Platform Support.

## 4. Immediate Containment
1. Open Operations Console (`/(ops)`) with authorized staff credentials.
2. Locate the stuck run using `analysisRunId` or correlation ID.
3. Inspect Temporal workflow status without downloading or viewing raw customer scientific matrices.
4. Check if the run is safely waiting for a human review signal (`QC_REVIEW_REQUIRED`) rather than stuck in error.

## 5. Recovery
1. If an activity is hanging on a blocked compute process:
   - Request cancellation via Temporal client: `workflowClient.cancel("analysis-run:" + analysisRunId)`.
   - Verify Modal container cleanup.
2. If cancellation succeeds, run state transitions to `CANCELLED` and usage is calculated up to the last successful step.
3. If the user wishes to restart: User triggers re-run from the last valid checkpoint artifact or starts fresh run.

## 6. Validation of Recovery
1. Verify workflow execution terminates cleanly in Temporal.
2. Confirm run state updates to `CANCELLED` or `FAILED` in PostgreSQL.
3. Confirm no orphaned Modal tasks remain running.

## 7. Customer Communication Criteria
- Support ticket update to customer explaining reason for timeout and confirming compute credit restoration if platform error was at fault.

## 8. Evidence Preservation
- Save Temporal activity error log, attempt count, and last heartbeat timestamp.

## 9. Postmortem Requirements
- If caused by unhandled activity timeout or missing heartbeat, patch activity options with explicit `startToCloseTimeout` and `heartbeatTimeout`.
