# Runbook: Cloudflare R2 Outage

## 1. Detection Signals
- Alert `R2StorageFailureRateSpike` triggers (> 1% failure over 5 minutes).
- Client browser reports upload initialization or multipart part upload failures (HTTP 500 / 503).
- Temporal Activities fail with S3/R2 client network timeout or access errors.

## 2. Severity Classification
- **SEV-2** (Analysis pipeline and upload blocking).

## 3. Owner
Infrastructure Lead / On-Call Engineer.

## 4. Immediate Containment
1. Check Cloudflare status page (`www.cloudflarestatus.com`).
2. Pause new scientific analysis submissions via operational feature flag `pause_new_analyses=true` to prevent jobs failing midway.
3. Keep running Temporal workflows in retry state; Temporal's activity retry policy will hold workflow progress without failing terminal state.

## 5. Recovery
1. Once Cloudflare R2 recovers, verify bucket accessibility via AWS CLI/S3 API:
   `aws s3 ls s3://cellweave-artifacts-prod/ --endpoint-url https://<ACCOUNT_ID>.r2.cloudflarestorage.com`.
2. Resume new analysis submissions via operational feature flag.
3. Allow pending Temporal activities to complete retries automatically.

## 6. Validation of Recovery
1. Perform synthetic upload and presigned URL download test of a test matrix.
2. Confirm stalled Temporal activities successfully resume without manual intervention.

## 7. Customer Communication Criteria
- Post status update: "Investigating degraded dataset upload and export availability."
- Direct notification to users whose active multipart uploads timed out.

## 8. Evidence Preservation
- Capture Cloudflare R2 error logs, edge status logs, and failed S3 API request IDs.

## 9. Postmortem Requirements
- Review Temporal activity backoff intervals and browser resumable upload recovery windows.
