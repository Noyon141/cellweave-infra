# CellWeave Monitoring, Observability & SLO Framework

## Three Pillars of Observability

1. **Structured Logs:**
   - JSON format across all services.
   - Structured correlation dimensions on every request/run:
     - `requestId`
     - `organizationId`
     - `projectId`
     - `analysisRunId`
     - `workflowId`
   - **Strict Data Sanitization:** NEVER log scientific matrices, gene vectors, patient identifiers, or sensitive raw filenames.
2. **Metrics:**
   - Application metrics: HTTP latency, error rates, DB connection pool saturation, R2 operation failures.
   - Workflow metrics: Queued runs, running runs, failed runs, step duration, retry rate, cancellations.
   - Scientific compute metrics: CPU/GPU seconds, peak memory consumption, OOM abort events, cells processed.
   - Business metrics: Active organizations, runs per organization, Polar sync lag, gross compute margin.
3. **Traces:**
   - End-to-end distributed tracing via OpenTelemetry propagating trace headers from Next.js -> Temporal Client -> Temporal Worker -> Modal Activities.

## Service Level Objectives (SLOs)

| Metric | Target | Error Budget (30-day) |
|---|---|---|
| **Web / API Monthly Availability** | 99.9% | ~43.2 minutes |
| **Workflow Request Durability** | > 99.99% | < 0.01% lost jobs |
| **Upload Verification Success Rate** | > 99.5% | < 0.5% failure |
| **Billing Event Reconciliation** | 100% | 0 unresolved drift |
| **Cross-Tenant Access Incidents** | 0 (Zero tolerance) | 0 incidents |

## Error Classification
- `PLATFORM_ERROR`: Infrastructure failures, cloud provider outages, network partitions, unhandled exceptions. Triggers platform alerting.
- `SCIENTIFIC_VALIDATION_ERROR`: Malformed input matrices, insufficient biological replicates, unmapped gene keys. Displayed to user as actionable scientific guidance; does NOT count against platform SLOs.

## Alerting Architecture & Vendor Neutrality
In accordance with `DO-NOT-GUESS.md`, the authoritative design fixes the required error classifications, SLO targets, and severity escalation rules (SEV-1 through SEV-4), but deliberately leaves the exact alerting platform/vendor unspecified.

Logical alert conditions, evaluation thresholds, and severities are defined in [`alerts/alert-rules.yaml`](./alerts/alert-rules.yaml) in a vendor-neutral format. Adapting these definitions to an operational notification service (e.g., PagerDuty, Opsgenie, Grafana OnCall, or cloud-native notification queues) remains an Operator Decision.
