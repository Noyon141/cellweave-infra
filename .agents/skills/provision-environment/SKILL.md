---
name: provision-environment
description: Provisions a CellWeave local/development/staging/production/preview environment with the required service separation and data/credential isolation.
---

# Provision Environment

1. Identify target environment.
2. Provision/separate the appropriate:
   - Neon project/branch
   - R2 prefix/bucket
   - Temporal namespace
   - Modal environment
   - Polar sandbox/production mode
   - OAuth credentials
   - secrets
3. Ensure production credentials are not reused.
4. Ensure previews do not use production customer data.
5. For staging, preserve the production architectural shape.
6. Configure observability and health checks.
7. Verify private object storage.
8. Verify service identities/scopes.
9. Run environment smoke tests.
10. Document teardown/recovery behavior.
