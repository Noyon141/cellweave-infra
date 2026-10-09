terraform {
  required_version = ">= 1.6.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.35"
    }
    neon = {
      source  = "kislerdm/neon"
      version = "~> 0.6.0"
    }
  }
}

module "r2_artifacts" {
  source      = "../../modules/cloudflare_r2"
  account_id  = var.cloudflare_account_id
  bucket_name = "cellweave-artifacts-prod"
  environment = "production"
  location    = "wnam"
}

module "neon_db" {
  source                    = "../../modules/neon"
  project_name              = "cellweave-prod"
  region_id                 = var.neon_region_id
  branch_name               = "main"
  history_retention_seconds = 2592000 # 30 days PITR for production
  min_cu                    = 0.5
  max_cu                    = 4.0
}

module "temporal_namespace" {
  source         = "../../modules/temporal_namespace"
  namespace_name = "cellweave-prod"
  retention_days = 30
  environment    = "production"
}
