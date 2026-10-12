# OpenTofu S3-Compatible Remote State Backend for Cloudflare R2
# Storage bucket is dedicated to infrastructure state and separated from application storage.
# Endpoint is supplied via -backend-config or AWS_ENDPOINT_URL_S3 environment variable.

terraform {
  backend "s3" {
    bucket                      = "cellweave-terraform-state"
    key                         = "infra/development/terraform.tfstate"
    region                      = "auto"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
    force_path_style            = true
    use_lockfile                = true
  }
}
