---
trigger: model_decision
description: "Use for CI/CD templates, build/release gates, preview deployment, science container release, or migration safety."
---

# CI/CD

Web PR:
install
→ lint
→ format
→ TypeScript typecheck
→ unit tests
→ authorization tests
→ DB migration validation
→ build
→ Playwright smoke
→ preview

Web production:
migration safety gate
→ deploy
→ health check
→ synthetic smoke
→ progressive feature activation

Science:
Python lint
→ type checks
→ unit tests
→ scientific regression
→ golden datasets
→ container build
→ SBOM
→ vulnerability scan
→ benchmark

A scientific algorithm update cannot deploy merely because unit tests pass.

CI/CD evidence is part of SOC2-friendly operation.
