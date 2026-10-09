---
trigger: always_on
description: "Preserves the CellWeave production deployment shape, independent scaling boundaries, and no-premature-Kubernetes rule."
---

# Deployment Boundaries

Production baseline:
- Vercel: Next.js web/API
- Neon: structured metadata
- Cloudflare R2: private scientific objects
- Temporal Cloud: durable orchestration
- always-on TypeScript Temporal Worker
- Modal: CPU/GPU scientific compute

The heaviest concerns scale independently:
web, database, storage, compute.

Large data does not flow through application servers.
Long-running work does not depend on HTTP request lifetime.
Large outputs do not live in Postgres.

Stage 1:
Vercel, Neon, R2, Temporal Cloud, 1–2 orchestrator replicas, Modal autoscaling.
No Kubernetes.

Stage 2:
more worker replicas, resource task queues, DB read scaling, result caching, higher Modal concurrency, per-org workflow limits.

Stage 3:
regional pools, enterprise queues, optional AWS Batch/ECS, dedicated storage/DB, cross-region DR.

Do not make Kubernetes a default before the product reaches the scale described by the design.
