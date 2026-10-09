# CellWeave Environment Architecture & Isolation Matrix

This document defines the environment strategy for CellWeave, establishing mandatory service separation and credential isolation across all development, staging, production, and preview environments.

## Environment Matrix

| Dimension | Local | Development | Staging | Production | Vercel Previews |
|---|---|---|---|---|---|
| **Purpose** | Developer workstations & offline execution | Continuous integration & feature testing | Pre-release qualification (Production shape) | Customer-facing production SaaS | Ephemeral pull request validation |
| **Postgres Database** | Local container (`postgres:16`) or dev Neon branch | Neon `development` branch | Neon `staging` branch | Neon `production` primary | Ephemeral Neon branch from sanitized staging |
| **Scientific Storage** | Local MinIO (S3-compatible) | Cloudflare R2 (`cellweave-artifacts-dev`) | Cloudflare R2 (`cellweave-artifacts-staging`) | Cloudflare R2 (`cellweave-artifacts-prod`) | Cloudflare R2 (`cellweave-artifacts-preview` or staging prefix) |
| **Orchestration** | Temporal CLI / local dev-server | Temporal Cloud namespace (`cellweave-dev`) | Temporal Cloud namespace (`cellweave-staging`) | Temporal Cloud namespace (`cellweave-prod`) | Temporal Cloud namespace (`cellweave-preview`) |
| **Compute Engine** | Local Python Docker / subprocess | Modal `dev` environment | Modal `staging` environment | Modal `prod` environment | Modal `preview` environment |
| **Billing Gateway** | Polar Sandbox / mock adapter | Polar Sandbox | Polar Sandbox | Polar Production | Polar Sandbox / mock adapter |
| **Auth & OAuth** | Local BetterAuth credentials | Dev Google OAuth Client | Staging Google OAuth Client | Production Google OAuth Client | Dev/Preview Google OAuth Client |
| **Email Gateway** | Mock / console output | Resend Test API key | Resend Staging API key | Resend Production API key | Mock / test mode |
| **Observability** | Console JSON logs / local OTel | Dev Sentry & OTel collector | Staging Sentry & OTel collector | Production Sentry & OTel collector | Preview Sentry |

---

## Critical Isolation Invariants

1. **Zero Production Customer Data in Previews:**
   - Production customer data must NEVER be copied or branched into preview deployments.
   - Ephemeral preview databases must branch strictly from sanitized staging schemas and synthetic seed datasets.
2. **Strict Credential Segregation:**
   - Production credentials are never shared with development or staging environments.
   - Each environment has independent secrets for database connections, object storage, Temporal, Modal, Polar, and BetterAuth.
3. **Staging Parity:**
   - Staging must preserve the complete architectural shape of production: Next.js on Vercel, Neon Postgres, Cloudflare R2, Temporal Cloud, always-on TypeScript Worker, and Modal elastic compute.
   - Staging exists specifically to uncover integration and concurrency defects that local development mocks conceal.
4. **Least-Privilege Worker Credentials:**
   - Science compute containers never receive primary database credentials, SaaS admin keys, or master R2 credentials.
   - Science compute receives only short-lived signed URLs for specific dataset inputs and artifact outputs.
