# WordEase Keyboard – Bug and Issue Tracker

This document logs bugs, feature issues, UX concerns, and critical blockers identified during the development and testing of the WordEase iOS keyboard project.

---

## 🔄 Issue Reporting Template

Use the following format when logging a new issue:

**ID:** (auto or manually assigned)
**Phase:** (e.g., Phase 2 – AI Integration Core)
**Title:** \[Short, clear title]
**Type:** Bug / Enhancement / Design Flaw / Performance
**Severity:** Low / Medium / High / Critical
**Environment:** (e.g., iPhone 16 Pro max, iOS 18.4 <, Wi-Fi, etc.)
**Description:**

> \[Brief explanation of what’s wrong and how it was discovered. Include relevant context.]

**Steps to Reproduce:**

1. …
2. …
3. …

**Expected Result:**

> \[What should happen]

**Actual Result:**

> \[What actually happens]

**Status:** Open / In Progress / Resolved / Deferred
**Assigned To:** (Developer/AI module/responsible agent)
**Date Logged:** (MM/DD/YYYY)
**Screenshots/Logs:** (Optional attachments or references)

---

## 📋 Example Entry

**ID:** #002
**Phase:** Phase 1 – Native Keyboard Foundation
**Title:** Predictive bar not displaying after emoji input
**Type:** Bug
**Severity:** Medium
**Environment:** iPhone 13 Mini, iOS 16.6, Wi-Fi
**Description:**

> Predictive text bar disappears when a user types an emoji followed by a space. This interrupts the user flow as suggestions are not shown afterward.

**Steps to Reproduce:**

1. Open Notes app
2. Activate WordEase keyboard
3. Type any emoji
4. Press spacebar

**Expected Result:**

> Predictive suggestions should continue after the emoji and space.

**Actual Result:**

> Predictive suggestions disappear.

**Status:** Open
**Assigned To:** iOS Keyboard Module
**Date Logged:** 05/29/2025
**Screenshots/Logs:** (linked in internal QA dashboard)

---

## 🗂️ Maintenance Tips

* Keep issues sorted by Phase and Severity
* Regularly audit for resolved or outdated bugs
* Link related issues to reduce duplication
* Tag blockers that affect next-phase progression

---

Use this document to keep development aligned and clean from regressions and overlooked flaws. Update as testing progresses through each phase.
