---
trigger: model_decision
description: "Use for autoscaling, task queues, quotas, cost tracking, provider capacity, compute admission, or future enterprise isolation."
---

# Cost / Capacity

Track cost by:
organization, project, run, workflow step.

Cost categories:
CPU, GPU, storage, egress, third party.

Compute-abuse controls:
plan quotas, per-org concurrency, rate limiting, compute admission, monthly budget, workflow priority.

Do not invent numeric limits before benchmark/plan decisions.

Tenant-scoped compute caching is allowed when cache identity includes input checksum, pipeline version, step version, parameter hash, reference version.

Shared cross-customer scientific artifact caching is prohibited initially.

Future dedicated storage/DB/compute/task queues are enterprise readiness, not default V1 infrastructure.
