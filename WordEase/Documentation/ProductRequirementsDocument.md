# Product Requirements Document (PRD)

## Product Name:

WordEase – AI Writing Assistant Keyboard

## Purpose:

To create a **native iOS system-level keyboard app** using Swift that integrates AI-powered writing assistance (similar to Wordtune) directly into the user’s typing experience across any app on their iPhone or iPad.

---

## Objective:

Deliver an intuitive keyboard experience that:

* Replaces the default iOS keyboard
* Provides real-time AI rewrite and tone suggestions as users type
* Fixes grammar and clarity on the fly
* Offers one-tap improvements (shorten, expand, formalize, etc.)
* Integrates with device-wide text input (email, messaging, notes, browser, etc.)

---

## Target Audience:

* iOS users
* Students
* Writers
* Business professionals
* Non-native English speakers
* Social media content creators

---

## Key Features:

### 1. System Keyboard:

* Native iOS `InputViewController` in Swift
* Supports standard typing, emoji, clipboard
* Toolbar with AI suggestion buttons
* Auto-capitalization, autocorrect, and spellcheck enabled
* Predictive text support like Apple’s default keyboard
* Custom layout with branding and iconography

### 2. AI Writing Assistance:

* Real-time rewrite suggestions as user types
* One-tap tone adjustment (Formal, Casual, Concise, Expand, and more)
* Grammar and clarity improvement
* Simplification for easy reading
* Context-aware suggestions based on current sentence
* Replaces full sentence when suggestion is selected
* Display 3–5 AI suggestions per query
* Option to rate or vote on AI suggestions

### 3. User Controls:

* Long-press or tap AI button for suggestions
* Toggle AI assistance on/off
* Tap to replace sentence
* Undo/Redo option
* Support offline typing if AI is unavailable

### 4. Settings Panel (Separate App):

* Theme selection (dark/light + manual toggle)
* Preferred tone selection
* Typing language settings
* AI behavior configuration (auto-trigger, suggestion style)
* History of all rewrites, accepted rewrites, and editable saved entries
* Feedback submission per suggestion
* Optional login for saved history and advanced features

---

## Optional Enhancements:

* Voice typing with AI refinement
* Multilingual input and translation
* AI personalization based on writing style
* Team dictionary and tone profiles

---

## Tech Stack:

### Native Keyboard:

* **iOS Only**: Swift + InputViewController
* App Group container for shared storage between keyboard and app

### AI Integration:

* OpenAI GPT-3.5 (via HTTPS requests using `URLSession`)
* API responses cached locally for retry/offline access
* Custom prompt templates for all tone types and rewrite modes

### Settings Companion App:

* SwiftUI or React Native + Expo (for managing preferences, history, and login)

### Authentication & Storage:

* Firebase Auth or Apple Sign-In
* Firestore or App Group + UserDefaults for synced and local storage

---

## Deployment & Distribution:

* iOS App Store with custom keyboard extension enabled
* Guided onboarding flow to help users enable and activate the custom keyboard
* App will request full access (with clear privacy explanation)

---

## Privacy and Ethics:

* No collection or storage of user-entered text for analytics
* Users will be notified that no input is collected, ensuring full transparency and privacy compliance

---

## Monetization Strategy:

### Free Tier (Basic):

* 30 daily AI suggestions and rewrites
* Unlimited spelling and grammar checks

### Advanced Tier (\$6.99/mo, billed annually):

* 30 daily AI suggestions and rewrites
* 15 monthly summarizations
* Unlimited spelling, grammar, and AI recommendations

### Unlimited Tier (\$9.99/mo, billed annually):

* Unlimited AI rewrites and suggestions
* Unlimited summarizations, vocabulary enhancements
* Clarity and fluency improvement features
* Premium support access

---

## User Flow:

1. User installs the app from App Store
2. Follows onboarding to enable WordEase Keyboard in iOS Settings
3. Types in any app with the keyboard
4. Taps toolbar to access AI suggestions (auto or manual)
5. Views 3–5 suggestions and applies preferred one
6. Uses the app to view/edit history, customize settings, and manage account

---

## UX/UI Requirements:

* Clean, responsive native keyboard layout
* Lightweight AI interaction (no lag)
* Toolbar with clear icons for each AI function
* Modern, intuitive companion settings app
* Wordtune-inspired visual aesthetic

---

## Development Roadmap (Phased with Real Data Testing)

Each phase must be completed with real data testing to verify functionality, UX, and backend integrations.

### Phase 1: Native Keyboard Foundation (4–5 weeks)

* Implement Swift-based `InputViewController`
* Custom keyboard layout with emoji, spellcheck, predictive text, and autocorrect
* Toolbar integration for future AI features
* Real data test: Ensure full typing experience across native apps with actual use cases

### Phase 2: AI Integration Core (2–3 weeks)

* Connect to OpenAI GPT-3.5 for rewrite, tone, and grammar suggestions
* Implement toolbar actions: Rewrite, Formal, Casual, Concise, Expand
* Display 3–5 suggestions per query
* Enable rating/voting on suggestions
* Real data test: Test suggestions on user-written sentences in diverse contexts

### Phase 3: Settings App + Data Sync (2 weeks)

* Build companion app with user login, preferences (tone, theme, language), and history
* Enable syncing with Firebase or local storage via App Group
* Real data test: Ensure cross-device setting persistence and UI reliability

### Phase 4: Limits, Feedback, and Subscription Logic (2–3 weeks)

* Implement daily usage tracking (e.g., 30 suggestions/day for free users)
* Add feedback forms and analytics events
* Integrate basic subscription logic with App Store in-app purchases
* Real data test: Simulate user limits, upgrade flow, and feedback logging

### Phase 5: Optimization and UX Polishing (2 weeks)

* Improve UI/UX polish, responsiveness, and error handling
* Review and update API prompts for better suggestions
* Accessibility compliance and localization prep
* Real data test: Broader internal testing across edge cases and devices

---

## Success Metrics:

* <300ms AI response time for suggestions
* 1,000+ active users in 3 months
* > 85% user satisfaction on typing experience
* > 70% daily keyboard retention rate
* > 10% upgrade to paid tier in 3 months

---

## Notes:

This PRD prioritizes **native Swift development for iOS** to fully support the system keyboard integration. Android support is deferred or optional. A React Native-based or SwiftUI companion app can be used for managing settings, user engagement, and subscription logic.

---

## Future Roadmap:

* Premium AI suggestion packs
* Keyboard themes and font styles
* Personal tone memory and writing analytics
* Team writing mode (enterprise feature)
* Android version built in Kotlin (future)
