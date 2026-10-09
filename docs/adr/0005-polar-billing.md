# ADR-0005: Polar Billing Integration & Architecture

## Status
Accepted (Authoritative Baseline)

## Context
CellWeave requires hybrid commercial monetization combining recurring team subscriptions, included resource allowances, and metered compute usage (CPU/GPU seconds, bytes processed, storage byte hours). Letting a third-party billing platform act as the authoritative entitlement engine leads to latency, tight coupling, and downtime vulnerability during webhook processing or provider outages.

## Decision
Polar is selected as the commercial billing provider, with strict separation between commercial transactions and internal entitlement authority:
1. CellWeave maintains an internal, immutable `usage_ledger` as the sole source of truth for scientific resource consumption and entitlement enforcement.
2. Polar serves as the commercial billing gateway (subscriptions, checkouts, customer portal, invoices).
3. Usage events are processed idempotently using the deterministic key `runId:stepId:attempt` via a transactional billing outbox pattern.
4. Entitlements are evaluated locally by CellWeave application logic; Polar webhook events project subscription status into local state, but Polar does not directly gate scientific pipeline execution.
5. Code interacts with Polar strictly through the `BillingProvider` interface.

## Consequences
### Positive
- System operates reliably even during temporary payment provider outages.
- Immutable audit ledger prevents billing discrepancy disputes.
- Retries and duplicate webhook deliveries cannot generate duplicate charges.

### Negative / Trade-offs
- Requires maintaining an outbox table, reconciliation workers, and periodic synchronization routines.

## Design Authority References
- `CellWeave Production Master System Design v1.0`, Section 67-73 ("Billing Architecture, Source of Truth, Polar Usage Flow"), Section 123 ("Billing Interface").
