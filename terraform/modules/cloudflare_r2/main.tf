resource "cloudflare_r2_bucket" "scientific_artifacts" {
  account_id = var.account_id
  name       = var.bucket_name
  location   = var.location
}

# Note: Cloudflare R2 CORS for direct browser multipart uploads is configured
# either via Cloudflare API or S3-compatible client with the r2-cors.json specification.
