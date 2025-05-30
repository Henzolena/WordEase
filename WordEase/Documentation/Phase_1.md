# Phase 1 Documentation: Native Keyboard Foundation

## Objective:

Establish a stable, Swift-based custom iOS keyboard with essential typing functionality and UI scaffolding for future AI features including Rewrite and Create actions.

---

## Deliverables:

* Fully functional custom keyboard using `InputViewController`
* Custom keyboard layout: QWERTY, emoji selector, predictive bar, punctuation row, spacebar, delete, return, and `.com` button
* Predictive text bar styled with smart completions
* Autocorrect and spellcheck integration with `UITextChecker`
* Toolbar with placeholder buttons: `✨ Rewrite` and `✨ Create`
* Full emoji support and emoji accessibility from toggle key
* App Group container setup for sharing data with settings app

---

## Technical Scope:

### Development:

* Create `KeyboardViewController` using `UIInputViewController`
* Build custom layout engine to manage flexible rows (alphabet, emoji, number/symbol)
* Integrate predictive text and suggestion engine using Apple APIs
* Implement system spellcheck and correction flows
* Insert static toolbar buttons for `Rewrite` and `Create` with responsive layout
* Configure App Group and shared container for future preference access

### UI/UX:

* Match look and feel of iOS system keyboard with custom enhancements
* Insert branded icons or animation placeholders for AI buttons
* Ensure responsive layout across iPhone and iPad screens
* Provide spacing and sizing to accommodate future popups or suggestions panel

---

## Testing Plan:

### Scope:

* Test across major apps: Safari, Gmail, Messages, Notes, App Store search
* Validate emoji support, punctuation access, autocorrect triggers
* Ensure stability and usability of `.com`, spacebar, delete, and return keys
* Confirm predictive bar suggestions are usable and accurate
* Test keyboard resizing and orientation adaptability

### Data:

Use realistic user input:

* Social media posts, messages, and formal text
* Inputs with typos, emojis, mixed casing, punctuation
* Text that would later trigger AI features (e.g., “rewrite this paragraph”)

---

## Acceptance Criteria:

* Keyboard launches consistently and functions without crash in supported apps
* Predictive text, spellcheck, and autocorrect operate as expected
* Toolbar includes visually consistent `Rewrite` and `Create` buttons
* Custom layout scales and adapts across devices and orientations
* Emoji and `.com` toggles are functional and accessible

---

## Next Phase Prerequisite:

* Keyboard layout is visually polished and functionally stable
* Toolbar is responsive and accurately positioned for AI integration
* Predictive/completion systems tested with real typing use cases
* Shared container communication validated for expansion in Phase 2

Once this phase is complete and passes real data testing, move to **Phase 2: AI Integration Core**.
