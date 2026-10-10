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
  bucket_name = "cellweave-artifacts-dev"
  environment = "development"
  location    = "wnam"
}

module "neon_db" {
  source                    = "../../modules/neon"
  project_name              = "cellweave-dev"
  region_id                 = var.neon_region_id
  branch_name               = "development"
  history_retention_seconds = var.neon_history_retention_seconds
  min_cu                    = 0.25
  max_cu                    = 1.0
}

module "temporal_namespace" {
  source         = "../../modules/temporal_namespace"
  namespace_name = "cellweave-dev"
  retention_days = var.temporal_retention_days
  environment    = "development"
}
