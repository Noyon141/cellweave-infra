# Infrastructure State Bootstrap

This stack provisions the minimum prerequisite infrastructure for remote OpenTofu state storage:
- Dedicated private Cloudflare R2 bucket: `cellweave-terraform-state`.

## Security & Architecture Constraints
1. **Separation from Application Storage:**
   - The application R2 bucket `cellweave-artifacts-dev` must NEVER store its own Terraform state.
   - `cellweave-terraform-state` is isolated and stores state objects partitioned by environment prefix:
     - `infra/development/terraform.tfstate`
     - `infra/staging/terraform.tfstate`
     - `infra/production/terraform.tfstate`
2. **Access Control:**
   - Managed via dedicated infrastructure R2 API tokens, separate from application runtime credentials.
   - Encrypted at rest (AES-256) and in transit (TLS 1.3).
