# ADR-0003: Temporal Durable Orchestration

## Status
Accepted (Authoritative Baseline)

## Context
Scientific pipelines take minutes to hours to execute across heterogeneous compute tiers. Serverless HTTP requests have short timeouts (e.g. 10s-300s). Naive background jobs with custom database queues suffer from partial failure states, lack of deterministic retry logic, worker crash vulnerability, and poor observability over human-in-the-loop review steps (such as interactive QC filtering review).

## Decision
Temporal Cloud is selected as the durable execution orchestrator, driven by an always-on TypeScript Temporal Worker:
1. Long-running scientific workflows are modeled as deterministic Temporal Workflows (`AnalysisWorkflow`).
2. Temporal is authoritative for workflow execution state, timers, retries, and activity progress; PostgreSQL remains authoritative for business records, permissions, and customer projections.
3. Interactive human checkpoints (e.g. QC threshold confirmation) are implemented via Temporal Signals (`confirmQC(parameters)`), suspending workflow progression safely without occupying CPU resources.
4. Stable, deterministic workflow IDs (`analysis-run:{analysisRunId}`) guarantee idempotency and eliminate duplicate executions.
5. All non-deterministic operations (database updates, HTTP requests, compute provider dispatch) are strictly encapsulated within Temporal Activities.

## Consequences
### Positive
- Workflow state survives process crashes, network partitions, and host restarts without data loss.
- Built-in exponential backoff retry for transient failures, and clean timeout handling.
- Human review gates run asynchronously without persistent server resource consumption.

### Negative / Trade-offs
- Requires maintaining an always-on worker process.
- Strict workflow determinism rules must be enforced in workflow code (no direct database access, randomness, or current clock calls in workflow functions).

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 9, Section 10, Section 36 ("Temporal Workflow Architecture"), Section 37 ("Temporal State vs Database State"), Section 38 ("Workflow IDs").
