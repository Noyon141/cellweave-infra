terraform {
  required_providers {
    neon = {
      source  = "kislerdm/neon"
      version = "~> 0.6.0"
    }
  }
}

resource "neon_project" "cellweave" {
  name                      = var.project_name
  region_id                 = var.region_id
  pg_version                = 16
  history_retention_seconds = var.history_retention_seconds
}

resource "neon_branch" "environment_branch" {
  project_id = neon_project.cellweave.id
  name       = var.branch_name
}

resource "neon_endpoint" "primary" {
  project_id = neon_project.cellweave.id
  branch_id  = neon_branch.environment_branch.id
  type       = "read_write"
  autoscaling_limit_min_cu = var.min_cu
  autoscaling_limit_max_cu = var.max_cu
}
