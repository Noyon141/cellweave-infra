# Secret Management & Independent Rotation Policy

## Core Invariants
1. **Never in Git:** Secrets must never be committed to git repositories, embedded in container images, written to client browser bundles, or logged.
2. **Environment Isolation:** Secrets are unique per environment (`development`, `staging`, `production`). Reusing production secrets in lower environments is strictly prohibited.
3. **Independent Rotation:** Every integration secret must support independent rotation without requiring platform-wide redeployments.

## Credential Inventory & Rotation Cadence

| Credential | Scope | Default Rotation Cadence | Emergency Rotation Procedure |
|---|---|---|---|
| **BetterAuth Secret** | Session encryption key | 180 days | Immediate key rotation with dual-key grace period |
| **Database Passwords** | Neon user & migrator roles | 90 days | Neon Console / CLI password regeneration + restart |
| **Cloudflare R2 API Keys** | S3-compatible service tokens | 90 days | Generate new token, update environment vars, delete old |
| **Temporal Cloud Certificates / Keys** | mTLS Client Certificate | 365 days (or before expiry) | Generate new cert in Temporal Cloud console, deploy to worker |
| **Modal API Tokens** | Compute dispatch tokens | 90 days | Regenerate via Modal web dashboard |
| **Polar API & Webhook Secrets** | Commercial billing | 180 days | Update webhook signing secret in Polar and CellWeave simultaneously |
| **Google OAuth Client Secret** | SSO integration | 365 days | Update in Google Cloud Console & Vercel environment |
