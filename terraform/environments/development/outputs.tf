output "r2_bucket_name" {
  description = "Development R2 bucket name"
  value       = module.r2_artifacts.bucket_name
}

output "neon_project_id" {
  description = "Development Neon project ID"
  value       = module.neon_db.project_id
}

output "neon_branch_id" {
  description = "Development Neon branch ID"
  value       = module.neon_db.branch_id
}

output "temporal_namespace" {
  description = "Development Temporal namespace"
  value       = module.temporal_namespace.namespace_name
}
