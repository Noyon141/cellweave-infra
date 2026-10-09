# Temporal Durable Orchestration Configuration

## Architecture Overview
CellWeave uses Temporal Cloud for durable, failure-resilient workflow orchestration. Temporal guarantees that multi-hour scientific analyses and human-in-the-loop validation gates survive process restarts, deployment updates, and transient network glitches.

## Namespaces
- `default`: Local development
- `cellweave-dev`: Development & automated CI integration tests
- `cellweave-staging`: Staging pre-production environment
- `cellweave-prod`: Production tenant workflows
- `cellweave-preview`: Ephemeral PR preview validation

## Workflow Identity Invariants
All workflow executions use deterministic IDs:
`analysis-run:{analysisRunId}`

This ensures that starting the same analysis run twice safely deduplicates to the same execution rather than double-billing or launching competing compute jobs.

## Workflow Signals
- `confirmQC(parameters)`: Resumes workflow progression after scientist reviews QC thresholds.
- `cancel`: Gracefully aborts current compute and finalizes usage.
- `manualAnnotationDecision`: Applies human-approved cluster re-annotations.
- `resumeAfterQuotaPurchase`: Unpauses workflow from `PAUSED_QUOTA` state.

## Retry Policies
- **Retryable Errors:** Network connectivity, temporary R2 errors, Modal rate-limiting/capacity backoff, transient database connection pooling timeouts.
- **Non-Retryable Errors:** Scientific malformed input, invalid metadata, schema violations, out-of-memory after enforced resource ceiling, quota exhaustion, permission failures.
