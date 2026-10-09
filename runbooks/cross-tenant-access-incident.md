# Runbook: Cross-Tenant Access Incident

## 1. Detection Signals
- Alert `CrossTenantAccessDetected` fires.
- Application error log records `TenantAccessViolationError` (user from Organization A attempted access to a resource belonging to Organization B).
- Bug bounty report or external penetration test finding reporting Insecure Direct Object Reference (IDOR).

## 2. Severity Classification
- **SEV-1** (Critical - Zero Tolerance Violation).
- Automatically triggers formal Security Incident Response procedure.

## 3. Owner
Chief Information Security Officer (CISO) / Lead Application Architect.

## 4. Immediate Containment
1. If active exploitation is ongoing, temporarily restrict access to the affected endpoint or enable maintenance mode for the affected feature.
2. Invalidate sessions of any suspicious client actors involved in the exploit.
3. Review web application firewall (WAF) logs and block offending client IPs.

## 5. Recovery
1. Identify the failing code path or missing `TenantContext` filter in application repository queries or API route handlers.
2. Formulate immediate patch enforcing strict `TenantContext` validation and where appropriate Postgres Row Level Security (RLS).
3. Run automated cross-tenant test suite locally and in staging:
   `pnpm test:auth:cross-tenant`.
4. Deploy emergency hotfix to production.

## 6. Validation of Recovery
1. Run automated penetration regression tests against the patched endpoint.
2. Confirm cross-tenant requests strictly return HTTP 403 / 404 with zero data leakage.

## 7. Customer Communication Criteria
- Under guidance of legal counsel and security policy, notify impacted organizations whose data was viewed or accessed during the incident window within 72 hours.

## 8. Evidence Preservation
- Export full HTTP request logs, database query logs, and affected data row IDs during the exposure window for forensic audit.

## 9. Postmortem Requirements
- Mandatory company-wide postmortem, review of automated authorization gates in CI, and verification of universal `TenantContext` enforcement.
