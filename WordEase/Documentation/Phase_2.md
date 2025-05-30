# Phase 2 Documentation: AI Integration Core

## Objective:

Integrate AI-powered writing suggestions into the keyboard with real-time access to OpenAI GPT-3.5 and enable rewrite/tone enhancement functionality.

---

## Timeline:

**Estimated Duration:** 2–3 weeks

## Deliverables:

* Secure API connection to OpenAI GPT-3.5
* Toolbar AI buttons: Rewrite, Formal, Casual, Concise, Expand
* Contextual sentence detection and selection
* Display area showing 3–5 suggestions
* Functionality to apply selected suggestion to input field
* Option to vote/rate each suggestion
* Caching system for API response storage (for offline retry)

---

## Technical Scope:

### Development:

* Use `URLSession` to call OpenAI GPT-3.5 API with custom prompts
* Develop sentence boundary detection logic
* Build prompt templates for:

  * Rewrite
  * Formal
  * Casual
  * Concise
  * Expand
* Render suggestions in overlay panel or dropdown UI within keyboard
* Handle user actions (apply, dismiss, rate)
* Implement local cache for recent suggestions using `UserDefaults` or file storage

### UI/UX:

* Each toolbar button triggers a loading state and then a results display
* Suggestions displayed in scrollable or stacked panel
* Active suggestion visibly highlighted upon selection
* Clear CTA (e.g., "Apply this")

---

## Testing Plan:

### Scope:

* Simulate real user typing and trigger AI requests
* Validate prompt correctness and output relevance
* Test multiple app contexts: Mail, Messages, Notes, third-party chat
* Stress test with long sentences, slang, and ambiguous phrasing

### Data:

Use diverse real-world sentences from:

* Professional email content
* Social media captions
* Casual text messages
* Non-native English grammar samples

---

## Acceptance Criteria:

* Toolbar actions reliably trigger AI suggestions
* Suggestions return within 1–2 seconds
* All 5 AI modes work and produce meaningful variations
* Suggestions can be applied seamlessly to input field
* Voting system is functional and feedback stored locally
* Suggestions are cached and available for retry offline

---

## Next Phase Prerequisite:

* All toolbar actions must be functional with real AI output
* Stable integration with OpenAI GPT-3.5 API
* Suggestion panel must be UX tested and responsive
* Local caching tested and verified

Once this phase is complete and tested with real data, proceed to **Phase 3: Settings App + Data Sync**.
