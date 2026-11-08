# Cally — Keys & accounts

What each milestone needs, where to get it, and what it costs. Derived from
`minical-analysis/07-integrations-and-api-keys.md`, adapted to **iOS + Android**
and to a **privacy-first, no-ads** default (see `docs/PLAN.md` §8).

**Golden rule:** no real key, token, certificate or config file is ever committed.
Secrets go in `.env` (git-ignored) or the platform's secret store / CI secrets.
Only `.env.example` (placeholders) is committed.

## By milestone

### M0 — Skeleton + month view (now)
Nothing. No account, no key. Runs on Linux with fakes and mock data.

### M1 — MVP (real device calendars)
| Thing | Why | Key? | Where | Cost |
|---|---|---|---|---|
| Nothing paid yet | `device_calendar` uses a **runtime permission**, not a key | no | — | free |
| (iOS build only) Apple Developer Program | needed to run on a real iPhone / TestFlight | account | developer.apple.com/programs | 99 USD/yr |
| (iOS build only) A Mac with Xcode 16+ | Arch Linux can't build iOS | hardware | — | — |

> Android needs no account to run on a device/emulator in debug. Calendar access
> is a runtime permission (`READ_CALENDAR`/`WRITE_CALENDAR`). Google/Outlook sync
> works through the **system account** the user already added — **no OAuth key**.

### M3 — Notifications
No key (local notifications only). Android 13+ needs the `POST_NOTIFICATIONS`
runtime permission; exact alarms need `SCHEDULE_EXACT_ALARM` + manifest receivers.

### M4 — Widgets
| Thing | Why | Where | Cost |
|---|---|---|---|
| iOS **App Group** id | share data app ⇄ WidgetKit | Xcode → Signing & Capabilities | free (needs the Apple Developer account) |
| No key for Android widgets | Glance/AppWidget is local | — | free |

### M5 — Cross-device sync of app-local data
| Option | Key? | Where | Cost |
|---|---|---|---|
| iCloud KV / CloudKit (iOS) | container id (not a secret) | Xcode → iCloud capability | free quota |
| Android sync mechanism | TBD at M5 | — | — |

### M7 — Pro (purchases)
| Thing | Why | Key? | Where | Cost |
|---|---|---|---|---|
| App Store Connect IAP | Pro (non-consumable) | account + Paid Apps agreement, tax/bank | App Store Connect | Apple takes 15–30% |
| Google Play Billing | Pro on Android | Play Console account | play.google.com/console | 25 USD one-time |
| RevenueCat (optional) | cross-platform purchases/restore | **public SDK key** → `.env` | revenuecat.com | free to ~2.5K USD MTR |

### Required to ship either store (any paid/public release)
- **Privacy policy + support URL** → a domain + static hosting (e.g. GitHub Pages). ≈10 USD/yr for the domain.

## Deliberately NOT used (privacy-first default)
AdMob + mediation, App Tracking Transparency/IDFA, Firebase Analytics/Crashlytics.
Dropping these lets Cally claim **"Data not collected."** If you choose to add
crash reporting later, prefer **Sentry** (DSN in `.env`) over Crashlytics, and
only after a privacy review.

## Optional, only if we add in-app sync/features (not planned)
- Google Calendar API OAuth client ids — only for *in-app* Google sign-in
  (we don't need it; we use the system account). Calendar scope is "sensitive"
  and requires Google verification.
- Microsoft Graph app registration — same story for in-app Outlook.
- Maps key (only if we embed a map instead of MapKit/opening external apps).
- Holiday data: free ICS feeds / Nager.Date (no key) preferred over keyed APIs.

## Where secrets live
- Local dev: `.env` (git-ignored), loaded at runtime; `.env.example` documents the keys.
- iOS native config (`GoogleService-Info.plist` etc.): **not committed**; provided on the Mac / CI.
- Android native config (`google-services.json` etc.): **not committed**.
- CI (Codemagic/GitHub Actions): signing certs, API keys → the CI secret store.
