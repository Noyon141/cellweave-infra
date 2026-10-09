# Preview Environment Data Sanitization & Non-Production Policy

## Non-Negotiable Invariants
1. **Zero Production Customer Data in Previews:**
   - Production customer datasets, project metadata, analysis runs, and comments must NEVER be copied, restored, or branched into PR preview deployments.
   - Any automated tool or script attempting to clone production customer data to preview environments is strictly blocked.
2. **Sanitized Baseline Strategy:**
   - Preview environments use Neon branch clones generated exclusively from a pre-sanitized staging schema baseline containing:
     - Synthetic test organizations and users.
     - Public benchmark datasets (e.g., 1k PBMC synthetic golden dataset).
     - Mock billing customer records.
3. **Automated Teardown:**
   - Previews are ephemeral. Branches and preview storage prefixes are deleted upon PR merge or closure.
