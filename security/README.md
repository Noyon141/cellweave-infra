# CellWeave Infrastructure Security & Governance

## Security Baseline
In accordance with `CellWeave Production Master System Design v1.0` Section 87–90:

- **TLS Everywhere:** All client-to-server and inter-service communications enforce TLS 1.3.
- **Encryption at Rest:** Neon database storage and Cloudflare R2 objects are AES-256 encrypted at rest.
- **Zero Raw Data in Logs/Traces:** Matrices, gene expressions, and patient IDs are scrubbed from telemetry.
- **Tenant Context Isolation:** Every tenant query requires a verified `TenantContext` containing `organizationId`.
- **SOC 2 Friendly Operations:** Access reviews, independent credential rotation, secret scanning, and automated CI security gates.

## Security Policies Index
- [Least Privilege Matrix](./policies/least-privilege-matrix.md)
- [Secret Management & Rotation](./policies/secret-management.md)
- [Service Identity & Scoped Credentials](./policies/service-identity.md)
- [Preview Data Sanitization & Zero PHI](./policies/preview-data-sanitization.md)
