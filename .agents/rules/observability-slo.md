---
trigger: model_decision
description: "Use for OpenTelemetry, Sentry, logs, metrics, traces, dashboards, alerts, SLOs, provider monitoring, or support diagnostics."
---

# Observability / SLO

Three pillars:
logs, metrics, traces.

Recommended:
OpenTelemetry, Sentry, central structured logs, Temporal observability, Modal metrics.

Correlation dimensions where safe:
requestId, organizationId, analysisRunId, workflowId.

Never log scientific matrices.

Application metrics:
HTTP latency/error, auth failures, DB latency, R2 failures.

Workflow:
queued/running/failed, retry rate, step time, cancellation.

Science compute:
CPU/GPU seconds, memory, OOM, cells processed, cost/run.

Business:
active orgs, runs/org, compute margin, storage/org, upgrades.

Initial SLO:
- web/API availability 99.9% monthly
- workflow request durability >99.99%
- upload verification >99.5%
- billing reconciliation 100%
- cross-tenant access 0

Scientific validation errors are not infrastructure failures.
