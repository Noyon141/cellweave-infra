---
trigger: model_decision
description: "Use for local developer environment, dev service substitutions, staging parity, or local scientific execution."
---

# Local Development / Staging

Local developer environment may run:
- Next.js
- local Postgres or dev Neon
- Temporal dev server
- local MinIO/S3-compatible storage or dev R2
- science Docker environment

Scientific pipeline must also be runnable locally on a small test dataset without Modal.

Provider adapters select LOCAL vs MODAL execution mode.

Do not turn local substitutes into new production architecture.

Staging must use the production architectural shape to catch integration failures:
Next.js, Temporal, orchestrator, Modal, R2, Postgres, Polar sandbox.
