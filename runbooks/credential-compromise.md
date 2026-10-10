# Runbook: Credential Compromise & Key Revocation

## 1. Detection Signals
- Secret scanning alert (Gitleaks, GitHub Secret Scanning, TruffleHog) indicates leak in public repository or build logs.
- Unexpected IP addresses accessing cloud provider APIs (Cloudflare, Neon, Modal, Temporal, Polar).
- Automated SOC 2 anomaly detection alert.

## 2. Severity Classification
- **SEV-1** (Critical Security Incident).
- Automatically triggers formal Security Incident Response procedure.

## 3. Owner
Security Officer / Lead Infrastructure Engineer.

## 4. Immediate Containment
1. Revoke the compromised credential immediately in the upstream provider console:
   - **Neon:** Reset role password via Neon Console or CLI.
   - **Cloudflare R2:** Delete compromised API token and create replacement.
   - **Temporal Cloud:** Revoke compromised mTLS certificate thumbprint.
   - **Modal:** Revoke API token in Modal team settings.
   - **Polar:** Revoke access token and rotate webhook secret.
   - **BetterAuth:** Trigger secret rotation in deployment environment variables.
2. Invalidate all active user sessions if BetterAuth or primary database credentials were exposed.

## 5. Recovery
1. Generate fresh high-entropy replacement secrets.
2. Inject updated credentials into Vercel and background worker environment variables.
3. Trigger atomic rolling deployment of Next.js and Temporal Worker services.
4. Verify all services reconnect successfully with new credentials.

## 6. Validation of Recovery
1. Confirm the old revoked credential returns HTTP 401 / Access Denied when queried.
2. Verify all application health checks pass with new credentials.
3. Audit access logs for unauthorized read/write activity during the compromise window.

## 7. Customer Communication Criteria
- If customer data exposure is confirmed, initiate customer security notification in accordance with customer agreement obligations.

## 8. Evidence Preservation
- Export cloud provider audit trails, IP access logs, and git commit history containing the leak.
- Lock all evidence in a tamper-proof forensic archive.

## 9. Postmortem Requirements
- Mandatory executive security postmortem within 48 hours detailing exposure window, compromised data scope, and remediation guardrails.
