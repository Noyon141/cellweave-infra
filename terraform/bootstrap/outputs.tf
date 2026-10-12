output "state_bucket_name" {
  description = "Name of the remote state storage bucket"
  value       = cloudflare_r2_bucket.terraform_state.name
}
