# Runbook: Polar Billing Outage

## 1. Detection Signals
- Alert `PolarWebhookSyncLag` triggers (> 1 hour sync backlog).
- Next.js `/api/webhooks/polar` reports HTTP delivery failures or Polar dashboard reports failing webhook events.
- Customer upgrade/checkout sessions fail with Polar API gateway errors.

## 2. Severity Classification
- **SEV-3** (Non-blocking for scientific pipeline; degraded billing operations).
- Escalates to **SEV-2** if users are blocked from essential upgrades or entitlements falsely expire.

## 3. Owner
Backend / Billing Engineer.

## 4. Immediate Containment
1. Confirm that internal scientific analyses continue uninterrupted: In accordance with ADR-0005, internal `usage_ledger` and local entitlement evaluation run autonomously from Polar.
2. Ensure scientific usage events continue accumulating safely in the local `polar_sync_outbox` table.
3. Prevent subscription downgrade or account suspension by temporarily holding automated account restrictions.

## 5. Recovery
1. When Polar resolves the outage, trigger outbox reconciliation worker to flush queued usage events.
2. In Polar dashboard, trigger replay of failed incoming webhook events.
3. Webhook idempotency keys ensure no duplicate subscriptions or charges are generated.

## 6. Validation of Recovery
1. Verify `polar_sync_outbox` count drops to zero pending items.
2. Confirm Polar customer meters match CellWeave `usage_aggregates` totals.

## 7. Customer Communication Criteria
- Communicate only if customer checkout/upgrade pages were visibly impaired.

## 8. Evidence Preservation
- Retain webhook payloads, outbox audit IDs, and Polar event logs.

## 9. Postmortem Requirements
- Document total outbox lag and verify zero duplicate billing charges occurred.
