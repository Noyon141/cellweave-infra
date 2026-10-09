output "project_id" {
  description = "The ID of the Neon project"
  value       = neon_project.cellweave.id
}

output "branch_id" {
  description = "The ID of the provisioned Neon branch"
  value       = neon_branch.environment_branch.id
}

output "endpoint_id" {
  description = "The ID of the primary compute endpoint"
  value       = neon_endpoint.primary.id
}

output "host" {
  description = "Database connection host"
  value       = neon_endpoint.primary.host
}
