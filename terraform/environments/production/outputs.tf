output "r2_bucket_name" {
  description = "Production R2 bucket name"
  value       = module.r2_artifacts.bucket_name
}

output "neon_project_id" {
  description = "Production Neon project ID"
  value       = module.neon_db.project_id
}

output "neon_branch_id" {
  description = "Production Neon branch ID"
  value       = module.neon_db.branch_id
}

output "temporal_namespace" {
  description = "Production Temporal namespace"
  value       = module.temporal_namespace.namespace_name
}
