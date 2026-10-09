---
name: disaster-recovery-test
description: Executes the CellWeave quarterly metadata/object recovery proof and validates RPO/RTO assumptions instead of merely trusting backups.
---

# Disaster Recovery Test

1. Restore metadata into an isolated environment.
2. Verify schema.
3. Verify representative organization/project/run metadata.
4. Resolve R2 object references.
5. Open representative artifacts.
6. Validate artifact/input checksums.
7. Measure recovery against Metadata RPO ≤1h and RTO ≤4h targets.
8. Verify production remains isolated.
9. Record failures and remediation.
10. Update runbook evidence.

A backup is not considered proven if this restore path has not succeeded.
