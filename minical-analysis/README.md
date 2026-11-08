# minical analysis — Phase 1

Documentation of how the iOS app **minical – Planner & Calendar** (minical Inc.) behaves, written so our own Flutter calendar app can be built from it. It describes behavior, structure and style only. No code, assets, icons, fonts, copy, name or logo from minical are included.

## Summary
1. minical is a minimalist **month-grid calendar** for iPhone, iPad, Apple Watch and Apple Silicon Macs. Its main draw is home and lock screen widgets. [STORE]
2. It has **no backend for events**. Every event and calendar is read and written through Apple's calendar database (EventKit), so iCloud, Google, Outlook and other accounts added in iOS Settings sync automatically. [STORE][INFERRED]
3. The main screen is a 6-row month grid with colored event chips in each cell. Below it are the selected date, a wide "New event" button and a templates button; there is no tab bar or floating button. [USAGE]
4. The event editor has title, all-day, start/end, duration, calendar, color, alerts, repeat, location (with map), URL (with a preview), notes, templates and suggestions from past events. [STORE]
5. There are ~15 home screen widget kinds (small, medium, large, and extra large on iPad), plus lock screen widgets, Watch complications and Control Center controls. [STORE]
6. Customization covers 38 color themes, 10 fonts, 21 app icons, text sizes, week start, highlighting, week numbers, 24h time and lunar dates. [STORE]
7. Notifications are **local** only: per-event alerts, default alerts, a daily digest, 7 sounds, and an icon badge (date, week number or event count). [STORE]
8. The business model is ads (AdMob + mediation) plus a one-time **Pro** unlock ($11.99) and three tip IAPs. [STORE]
9. Pro removes ads and unlocks unlimited templates, all themes, fonts and icons, copying events to multiple dates, and week numbers. [STORE]
10. **The app bundle could not be inspected** (Intel Mac, see 11-open-questions.md). Everything comes from the App Store, minical's help site, third-party trackers and 6 screenshots (light mode, free version).

## Index
| File | Content | Status |
|---|---|---|
| [01-overview.md](01-overview.md) | What it is, audience, platforms, version | done |
| [02-features.md](02-features.md) | Full feature list, free vs Pro | done |
| [03-screens-and-navigation.md](03-screens-and-navigation.md) | Screens, navigation, gestures | home, search, date picker, editor done; settings etc. pending screenshots |
| [04-design.md](04-design.md) | Layout, colors, typography, spacing, motion | light mode measured; dark mode and themes pending |
| [05-widgets.md](05-widgets.md) | Widgets, complications, controls | large month widget observed; others pending |
| [06-data-model.md](06-data-model.md) | Entities and fields | done |
| [07-integrations-and-api-keys.md](07-integrations-and-api-keys.md) | Services, keys, accounts, costs | done |
| [08-permissions-and-privacy.md](08-permissions-and-privacy.md) | iOS permissions and privacy | done (inferred, no bundle) |
| [09-monetization.md](09-monetization.md) | Pro, pricing, ads | done |
| [10-improvements.md](10-improvements.md) | Our ideas | empty, for us |
| [11-open-questions.md](11-open-questions.md) | Unverified points | ongoing |
| [SCREENSHOT-CHECKLIST.md](SCREENSHOT-CHECKLIST.md) | What to capture | 6 of ~100 captured (02a, 02f, 03b, 04a, 06l light) |
| `screenshots/` | Images | 6 PNGs, light mode, free version |
| `raw/` | Raw command output and source list | — |

## Source tags
- **[BUNDLE]** verified in the app files (none so far: the bundle was not available)
- **[USAGE]** seen in screenshots (`screenshots/IMG_7582–7587`)
- **[STORE]** App Store listing or minical's official help site
- **[INFERRED]** hypothesis, to be verified
