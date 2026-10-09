# Modal Scientific Compute Deployment Guidelines

## Overview
`cellweave-science` deploys elastic compute routines on Modal. Modal provides serverless container execution for scientific Python workloads (Scanpy, Scrublet, scvi-tools).

## Resource Profile Mappings

The scientific activities declare high-level resource classes mapped to Modal container profiles:

| Resource Class | CPU Cores | Memory (RAM) | GPU Acceleration | Typical Use Case |
|---|---|---|---|---|
| `CPU_SMALL` | 2 vCPU | 4 GB | None | QC metrics, cell filtering, simple statistics |
| `CPU_MEMORY` | 4 vCPU | 16 GB | None | Standard normalization, HVG selection, PCA |
| `CPU_HIGH_MEMORY` | 8–16 vCPU | 32–64 GB | None | Large neighbor graph, Leiden clustering |
| `GPU_SMALL` | 4 vCPU | 16 GB | NVIDIA T4 / A10G | Basic scVI embeddings |
| `GPU_LARGE` | 8 vCPU | 32 GB | NVIDIA A100 | Large scVI/scANVI training, foundation models |

## Security Invariants
1. **Isolated Credentials:** Modal science containers NEVER receive primary database credentials, BetterAuth secrets, or master Cloudflare R2 credentials.
2. **Pre-signed Access Only:** Input data is retrieved via short-lived pre-signed GET URLs; output artifacts are pushed via scoped pre-signed PUT URLs or temporary credentials.
3. **Deterministic Ceilings:** Every job receives strict timeout (`maxRuntime`) and memory limits (`maxComputeUnits`) enforced before execution.
