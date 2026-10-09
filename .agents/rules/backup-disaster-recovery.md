---
trigger: model_decision
description: "Use for backups, restore, RPO/RTO, R2 durability, DR testing, cross-provider replication, or deletion recovery."
---

# Backup / Disaster Recovery

Metadata:
- Neon PITR
- scheduled logical backups

Initial targets:
- Metadata RPO ≤ 1 hour
- Metadata RTO ≤ 4 hours

R2:
- soft deletion
- delayed purge
- checksums
- artifact manifests

Quarterly backup test:
1. restore DB into isolated environment
2. verify schema
3. verify project metadata
4. resolve R2 references
5. open representative artifacts
6. validate checksums

A backup not restored in test is not proven.

Higher enterprise requirements may add cross-provider encrypted replication; do not make it V1 default.

Deletion lifecycle and recovery window remain distinct from backup existence.
