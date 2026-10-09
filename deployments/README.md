# CellWeave Deployment Architecture & Definitions

## Stage 1 Deployment Baseline

In accordance with `CellWeave Production Master System Design v1.0` Section 164 & 165:

```
Browser (Next.js UI)
  │
  ▼
Vercel (App Router, Server Actions, Route Handlers, BetterAuth)
  │
  ├──► Neon PostgreSQL (Structured metadata, permissions, audit events)
  ├──► Cloudflare R2 (Private scientific datasets, visualization artifacts)
  └──► Temporal Cloud (Durable execution engine)
        │
        ▼
   Temporal Worker (TypeScript / Node.js always-on container process)
        │
        ▼
   Modal (Elastic serverless CPU & GPU scientific workers)
        │
        ├──► R2 (Stream results, arrow embeddings, .h5ad)
        └──► Neon (Projections, usage records, workflow steps)
```

## Boundaries That Must Never Collapse
1. **Web / Business:** Next.js must never run scientific computation or heavy data crunching.
2. **Orchestration:** Temporal Worker exposes no customer REST API and is not a business database.
3. **Scientific Compute:** Modal containers execute pure scientific algorithms without SaaS auth or master database credentials.
4. **Scientific Storage:** Large matrices and artifacts live in R2; Postgres holds only structured metadata and indexes.
5. **No Premature Kubernetes:** Stage 1 intentionally uses managed serverless and lightweight containers; Kubernetes is avoided.
