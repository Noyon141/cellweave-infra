# Runbook: Google OAuth / Authentication Outage

## 1. Detection Signals
- Sentry alerts on BetterAuth Google OAuth callback errors (`oauth_callback_failed`).
- Spike in login failures on `/auth/sign-in`.
- Google Cloud Console API status indicates OAuth2 service degradation.

## 2. Severity Classification
- **SEV-2** (User login disruption).

## 3. Owner
Security / Application Lead.

## 4. Immediate Containment
1. Verify existing active user sessions: BetterAuth session cookies continue to validate without calling Google OAuth.
2. Ensure users with existing email/password credentials can continue to authenticate directly.
3. Display non-intrusive banner on sign-in page: "Google Sign-In is temporarily degraded; existing email/password logins remain operational."

## 5. Recovery
1. Check Google Cloud Console OAuth Client configuration, redirect URIs, and quotas.
2. If credentials expired or were revoked, rotate `GOOGLE_CLIENT_SECRET` in environment settings and redeploy.
3. Once Google resolves platform issues, test login callback on staging and production.

## 6. Validation of Recovery
1. Perform automated synthetic OAuth handshake login test.
2. Verify new session creation and audit event generation (`auth.session_created`).

## 7. Customer Communication Criteria
- Post status update on status page if outage exceeds 15 minutes.

## 8. Evidence Preservation
- Capture BetterAuth error logs (stripping any tokens or credentials).

## 9. Postmortem Requirements
- Review fallback authentication workflows and session lifetime configurations.
