# Vercel Preview Deployment Environment Strategy

## Overview
Vercel preview environments are automatically generated for pull requests across `cellweave-web`. To protect customer data and uphold strict multi-tenant security boundaries, previews follow these non-negotiable rules.

## Core Rules

1. **Zero Production Data:**
   - Production customer data must NEVER enter preview deployments.
   - Arbitrary PR previews must NEVER branch from production Neon databases.
2. **Ephemeral Neon Branching from Sanitized Staging:**
   - Preview databases use ephemeral Neon branches spawned dynamically from a sanitized staging schema and synthetic seed data.
   - Upon PR closure or merge, the ephemeral Neon branch is automatically destroyed.
3. **Storage Isolation:**
   - Previews use either a dedicated preview bucket (`cellweave-artifacts-preview`) or a sandboxed path prefix (`preview/{pr_number}/`) within the staging R2 bucket.
   - Ephemeral lifecycle rules automatically purge preview objects according to preview retention configuration.
4. **Billing & External Services in Sandbox:**
   - Previews use Polar sandbox credentials with mock webhook endpoints.
   - Email gateways operate in mock/sandbox mode to prevent accidental email delivery to real scientists or biotech teams.
