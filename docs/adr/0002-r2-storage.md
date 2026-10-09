# ADR-0002: Cloudflare R2 Object Storage

## Status
Accepted (Authoritative Baseline)

## Context
Single-cell RNA-seq datasets and derived artifacts range from hundreds of megabytes to tens of gigabytes. Storing these binary payloads in relational databases (PostgreSQL) causes severe bloat, slow backups, and performance degradation. Furthermore, passing multi-gigabyte uploads through application server request bodies (such as Vercel serverless functions) exceeds runtime limits, exhausts bandwidth, and increases cold starts. Finally, traditional cloud storage egress fees represent an unpredictable financial liability.

## Decision
Cloudflare R2 is adopted as the primary scientific object storage for CellWeave:
1. R2 buckets are strictly private; no dataset bucket is public.
2. Uploads bypass application servers: Next.js authorizes upload sessions and returns presigned/multipart upload URLs; the browser uploads directly to R2.
3. Access to artifacts and downloads is strictly mediated by short-lived presigned URLs generated after server-side tenant authorization checks.
4. Storage paths follow strict organizational partitioning: `org/{orgId}/project/{projectId}/datasets/{datasetVersionId}/...` and `org/{orgId}/project/{projectId}/runs/{runId}/...`.
5. Business logic interacts with storage solely through an abstract `ObjectStorage` interface, preventing vendor lock-in.

## Consequences
### Positive
- Zero egress fees for reading scientific artifacts and visualization streams.
- Relational database remains lightweight and dedicated to structured metadata.
- Large uploads do not bottleneck Next.js / Vercel execution limits.
- High durability and native S3 API compatibility.

### Negative / Trade-offs
- ETag on multipart R2 uploads does not correspond to standard SHA-256; an explicit ingest verification step must compute the authoritative scientific SHA-256 hash.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 9, Section 14, Section 47 ("Storage Architecture"), Section 48, Section 122 ("Storage Interface").
