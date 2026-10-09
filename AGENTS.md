# CellWeave Infrastructure — Agent Constitution

## Authority
`docs/architecture/CellWeave-Production-Master-System-Design-v1.0.pdf` is authoritative.

## Repository responsibility
This repository owns:
- Terraform/OpenTofu
- environment definitions
- Cloudflare configuration
- Temporal configuration
- deployment definitions
- monitoring configuration
- security policies
- CI templates
- runbooks

It does not redefine product/domain/scientific behavior.

## Deployment baseline
Production shape:
Browser → Vercel → Neon/R2/Temporal Cloud → always-on TypeScript Temporal Worker → Modal CPU/GPU → scientific artifacts.

Initial orchestration worker runs on a lightweight always-on container/background-worker platform. The exact initial provider is not selected by the design; do not silently standardize one. It may later move to ECS/Fargate without changing architecture.

## Environments
Required:
local, development, staging, production, plus Vercel previews.

Production data never goes to previews.
Production credentials never go to development.

Staging must preserve production architectural shape.

## Security / reliability
Least privilege, isolated secrets, private storage, short-lived credentials/URLs, backups, restore tests, observability, vulnerability management, runbooks, and incident severity handling are mandatory.

Do not introduce Kubernetes in early stages; the design explicitly avoids premature infrastructure complexity.
