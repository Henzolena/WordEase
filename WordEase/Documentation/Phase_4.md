# Phase 4 Documentation: Limits, Feedback, and Subscription Logic

## Objective:

Implement usage limits for free users, enable structured user feedback, and integrate App Store in-app subscription logic for premium tiers.

---

## Timeline:

**Estimated Duration:** 2–3 weeks

## Deliverables:

* Daily usage counter for AI suggestions (e.g., 30 suggestions/day for free users)
* Upgrade prompt and paywall modal for users exceeding daily limit
* Feedback submission feature per suggestion (e.g., thumbs up/down + optional comment)
* Subscription plans setup in App Store Connect

  * Free (Basic)
  * Advanced (\$6.99/mo billed annually)
  * Unlimited (\$9.99/mo billed annually)
* In-app purchase integration using StoreKit
* Premium feature access control based on user plan
* Plan syncing and verification using Firebase or App Group storage

---

## Technical Scope:

### Development:

* Track and store daily suggestion usage count
* Store feedback locally and sync with Firebase/Firestore
* Implement upgrade modal with plan highlights and CTA
* Use `StoreKit` to fetch products and process payments
* Verify receipts and store subscription status securely
* Enforce feature limits based on plan (e.g., disable suggestions if limit exceeded)

### UI/UX:

* Clear messaging when usage limit is reached
* Non-intrusive upgrade prompts with benefit highlights
* Clean feedback UI per suggestion with one-tap options
* Subscription screen with toggles for plan comparison and billing info

---

## Testing Plan:

### Scope:

* Test daily usage limits with realistic frequency
* Simulate upgrade and plan switching workflows
* Test in-app purchase validation, edge cases, and failed payments
* Validate feedback logging and sentiment tagging

### Data:

* Use real typing sessions to hit 30 daily suggestion cap
* Submit realistic user feedback for suggestion relevance and tone
* Simulate valid and invalid receipts for subscription validation

---

## Acceptance Criteria:

* Daily usage cap is enforced and resets every 24 hours
* Feedback can be submitted, stored, and synced
* In-app purchases work for all tiers with receipt validation
* Subscription status persists across app restarts
* UI clearly reflects plan limitations and encourages upgrades

---

## Next Phase Prerequisite:

* Usage tracking, feedback, and payment flows stable and verified with real users
* Subscription status syncs reliably across keyboard and settings app
* Paywall and upgrade messages are tested and aligned with user behavior

Once complete, continue to **Phase 5: Optimization and UX Polishing**.
