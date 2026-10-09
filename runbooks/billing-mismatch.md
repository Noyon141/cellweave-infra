# Runbook: Billing / Usage Mismatch

## 1. Detection Signals
- Reconciliation check alert: discrepancy detected between internal `usage_ledger` aggregates and Polar metered usage.
- Customer support ticket reporting inaccurate credit deduction or unexpected overage charge.

## 2. Severity Classification
- **SEV-2** (Customer billing discrepancy).

## 3. Owner
Billing Lead / Backend Engineer.

## 4. Immediate Containment
1. Temporarily pause automated credit overage charging for affected organization.
2. Ensure no customer analyses are interrupted: local entitlement evaluation continues.

## 5. Recovery
1. Query internal immutable `usage_ledger` for the customer organization across the billing period:
   `SELECT sum(compute_credits) FROM usage_ledger WHERE organization_id = :org_id AND created_at BETWEEN :start AND :end;`.
2. Compare with Polar customer meters via Polar API.
3. Identify missing or duplicate usage records:
   - Check `polar_sync_outbox` for unacknowledged events.
   - Verify that deterministic idempotency keys (`runId:stepId:attempt`) prevented double billing.
4. Manually or via script resynchronize the delta to Polar.
5. If overcharge occurred, issue immediate Polar credit refund or balance adjustment.

## 6. Validation of Recovery
1. Confirm ledger total and Polar reported meter match to 100% precision.
2. Confirm customer dashboard displays accurate remaining compute credits.

## 7. Customer Communication Criteria
- Send transparent breakdown of corrected usage to organization billing owner within 24 hours.

## 8. Evidence Preservation
- Snapshot `usage_ledger` rows and Polar meter sync audit logs before and after adjustment.

## 9. Postmortem Requirements
- Identify root cause of sync failure (network drop, webhook delivery race, or schema mismatch) and patch outbox reconciliation logic.
