---
trigger: always_on
description: "Applies CellWeave least-privilege, secrets, service identity, storage, scanning, and SOC2-ready security controls."
---

# Infrastructure Security

Security baseline:
- TLS everywhere
- encryption at rest
- private object storage
- short-lived signed URLs
- least-privilege credentials
- strict tenant authorization support
- rate limiting support
- secure headers support
- CSRF where relevant
- secure SameSite cookies
- session rotation support
- webhook verification
- idempotency
- dependency scanning
- secret scanning
- container vulnerability scanning
- audit logging

Secrets never enter Git, browser bundle, scientific artifacts, run manifests, logs.

Separate secrets by environment.
Rotate independently:
BetterAuth, Google OAuth, Neon, R2, Temporal, Modal, Polar, Resend, Sentry.

Science containers do not receive primary DB credentials or master SaaS/provider credentials.

Service identities use short-lived signed credentials with issuer/audience/scope/expiration.

SOC2-friendly operational controls begin early; certification timing remains business-driven.
