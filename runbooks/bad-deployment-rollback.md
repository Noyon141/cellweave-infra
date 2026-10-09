# Runbook: Bad Deployment Rollback

## 1. Detection Signals
- Post-deployment synthetic smoke tests fail.
- Immediate spike in HTTP 500 errors or uncaught exceptions reported to Sentry.
- Temporal worker failing to poll task queues due to fatal runtime initialization error.

## 2. Severity Classification
- **SEV-2** (Release regression / service degradation).

## 3. Owner
Release Engineer / On-Call SRE.

## 4. Immediate Containment
1. Freeze further production deployments immediately.
2. In Vercel console or CLI: Instantly promote previous production deployment alias:
   `vercel rollback <previous-deployment-id>`.
3. If Temporal Worker is affected: Roll back worker container image tag to previous stable digest on background worker platform.

## 5. Recovery
1. **Database Migration Safety Check:**
   - Verify whether the bad deployment applied database migrations.
   - In accordance with Section 104, database migrations must use the expand-contract pattern; the database schema must remain backward-compatible with the previous software version.
   - Do NOT run destructive down migrations while rolling back.
2. Verify previous version software starts cleanly against current database schema.
3. Monitor error rates in Sentry and health check endpoints.

## 6. Validation of Recovery
1. Run automated synthetic smoke test suite against production:
   `pnpm test:e2e:production-smoke`.
2. Confirm error rates return to pre-deployment baseline (< 0.1%).
3. Verify active user workflows continue processing without interruption.

## 7. Customer Communication Criteria
- If downtime or severe degraded functionality was visible to users for > 5 minutes, post incident resolution note on status page.

## 8. Evidence Preservation
- Tag and preserve the regressed container image and git commit SHA.
- Retain deployment build logs, Sentry error traces, and smoke test failure logs.

## 9. Postmortem Requirements
- Conduct postmortem to identify why CI/CD preview, unit, integration, or staging smoke tests failed to detect the regression before production deployment.
