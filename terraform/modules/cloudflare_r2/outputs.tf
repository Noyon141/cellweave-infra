output "bucket_name" {
  description = "The name of the provisioned R2 bucket"
  value       = cloudflare_r2_bucket.scientific_artifacts.name
}

output "bucket_id" {
  description = "The ID of the provisioned R2 bucket"
  value       = cloudflare_r2_bucket.scientific_artifacts.id
}
