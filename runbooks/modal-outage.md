# Runbook: Modal Compute Outage

## 1. Detection Signals
- Temporal Activity dispatch to Modal fails with connection errors, HTTP 503, or task dispatch timeouts.
- Modal dashboard status indicator shows regional or API degradation (`status.modal.com`).
- Sentry alerts on `ModalComputeProvider` invocation failures.

## 2. Severity Classification
- **SEV-2** (Scientific computation blocked).

## 3. Owner
Bioinformatics Platform Lead / Infrastructure Engineer.

## 4. Immediate Containment
1. Check Modal status page.
2. Ensure Temporal Activities classifying the error as `PLATFORM_ERROR` enter exponential backoff retry rather than failing the overall workflow.
3. Verify that running workflows do not transition to terminal `FAILED` prematurely.

## 5. Recovery
1. Once Modal service returns to operational status, verify modal CLI connectivity:
   `modal app list`.
2. Allow Temporal activities to automatically retry pending compute jobs.
3. If specific Modal containers are wedged, issue cancel via Modal CLI and allow Temporal retry to spawn fresh container instances.

## 6. Validation of Recovery
1. Dispatch test scientific container run (small synthetic dataset QC).
2. Confirm container completes and pushes output manifests to R2.

## 7. Customer Communication Criteria
- Update status banner: "Scientific analysis compute is experiencing delays due to third-party compute provider maintenance."

## 8. Evidence Preservation
- Save Modal task execution IDs, stderr outputs, and Temporal Activity retry attempt histories.

## 9. Postmortem Requirements
- Assess whether activity timeout settings and retry backoff intervals adequately cushioned the outage.
