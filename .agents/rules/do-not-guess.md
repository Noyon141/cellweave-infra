---
trigger: always_on
description: "Prevents unspecified infrastructure vendors, limits, or future enterprise topology from becoming accidental architecture."
---

# Do Not Guess

Read `docs/architecture/DO-NOT-GUESS.md`.

Do not silently choose:
- initial always-on worker hosting provider
- feature-flag vendor
- central log backend
- alerting vendor
- exact rate limits
- exact budgets/resource ceilings
- cross-provider replication for ordinary customers
- Kubernetes
- dedicated enterprise infrastructure for standard tenants

Implement only what the design fixes.
