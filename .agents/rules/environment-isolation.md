---
trigger: always_on
description: "Enforces local/development/staging/production/preview separation and prevents production data/credential leakage."
---

# Environment Isolation

Required:
- local
- development
- staging
- production
- Vercel previews

Separate:
- Neon projects/branches
- R2 prefixes or buckets
- Temporal namespaces
- Modal environments
- Polar sandbox/production
- OAuth credentials
- secrets

Production credentials are never shared with development.

Production customer data is never copied to preview deployments.

Preview DB strategy:
ephemeral Neon branches from sanitized staging schema/data.
Never branch arbitrary PR environments directly from production customer scientific metadata.

Development/test data:
public or synthetic.

Staging uses same architectural shape as production:
Next.js, Temporal, orchestrator, Modal, R2, Postgres, Polar sandbox.
