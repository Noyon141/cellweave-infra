---
name: production-qualification
description: Runs CellWeave Phase 14 production qualification across security, load, scientific benchmarks, DR, billing, tenant isolation, and failure injection.
---

# Production Qualification

Do not approve general production until critical gates pass:

- security testing
- auth penetration review
- cross-tenant automated tests
- tenant isolation review
- load testing
- scientific benchmark suite
- backup restore / DR exercise
- deletion workflow
- Polar reconciliation
- workflow crash/recovery
- Modal failure
- R2 upload interruption
- run cancellation
- quota enforcement
- audit log
- incident runbooks
- Terms/Privacy review
- failure injection

Record evidence and unresolved failures.
Deployment alone is not production readiness.
