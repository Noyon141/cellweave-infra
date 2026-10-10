# Cloudflare R2 & Edge Infrastructure Configuration

## Overview
CellWeave relies on Cloudflare R2 for zero-egress, high-durability object storage holding large single-cell datasets (`canonical.h5ad`), intermediate matrices, visualization Arrow buffers, and reproducibility export bundles.

## Key Security Architecture

1. **Private Buckets Only:**
   - All R2 buckets (`cellweave-artifacts-dev`, `cellweave-artifacts-staging`, `cellweave-artifacts-prod`, `cellweave-artifacts-preview`) are strictly private.
   - Public R2 bucket access is disabled.
2. **Direct Browser Upload Architecture:**
   - Large scientific files never pass through Next.js / Vercel request bodies.
   - Authorized Next.js endpoints generate short-lived presigned multipart upload URLs.
   - Browser client streams chunks directly to R2 using CORS policies defined in [`r2-cors.json`](./r2-cors.json).
3. **Download Authorization Flow:**
   - Client requests download -> CellWeave API verifies tenant & project permissions -> generates short-lived signed GET URL (expiration <= 15 minutes) -> Client downloads directly from R2.
4. **Lifecycle & Quarantine:**
   - Unverified uploads land in a logical quarantine status.
   - Lifecycle and reconciliation rules automatically clear orphaned multipart upload parts according to storage policy.
