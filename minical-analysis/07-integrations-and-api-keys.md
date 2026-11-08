# 07 — Integrations and API keys

No key values were found or recorded. The bundle was not available, so this comes from the store listing, the privacy policy and SDK trackers. Every key listed is something **we** must create ourselves.

## What minical uses [STORE]
| Service | Purpose in minical | Source |
|---|---|---|
| Apple EventKit | read/write events and calendars | [STORE] |
| iOS calendar accounts (iCloud, Google, Outlook, Naver) | sync, through iOS Settings; no in-app OAuth | [STORE] |
| iCloud (CloudKit or the key-value store) | sync custom event colors between devices | [STORE][INFERRED tech] |
| Contacts (system Birthdays calendar) | birthdays | [STORE] |
| StoreKit | Pro + tips | [STORE] |
| Google Firebase Analytics + Crashlytics | analytics, crashes | [STORE] privacy policy, AppGoblin |
| Google AdMob + mediation (LINE/LY Ads, Pangle, Mintegral, Liftoff/Vungle, InMobi, ironSource, DT Exchange) | ads | [STORE] |
| App Tracking Transparency | ad personalization (IDFA) | [STORE] |
| Map apps via URL (Apple Maps, Google Maps, Naver Map, Waze) | open locations | [STORE] |
| MapKit | map preview in the editor | [INFERRED] |
| LinkPresentation / Open Graph fetch | URL thumbnail | [INFERRED] |
| WidgetKit, App Intents, ControlWidget, watchOS | widgets, Shortcuts, controls, Watch | [STORE] |
| Local notifications (UserNotifications) | alerts, digest, badge | [STORE] |
| No own backend for sharing | sharing uses the providers' own sharing | [STORE] |

## What we will need
| Service | Purpose | Key or account needed? | Which one | How to get it | Cost | Required / optional |
|---|---|---|---|---|---|---|
| Apple Developer Program | Distribute on the App Store; needed for App Groups (widgets), iCloud, IAP, Watch, alternate icons on device | Account | Apple Developer membership + Bundle IDs, App Group id, signing certificates | developer.apple.com/programs → enroll | 99 USD/year | **Required** (iOS) |
| Mac with Xcode | Build iOS app + Swift widget/watch extensions | Hardware | Xcode 16+ on macOS 14.5+ (this Intel Mac on 14.8.7 qualifies; Apple Silicon is better) | Mac App Store | free | **Required** (Arch Linux cannot build iOS) |
| App Store Connect – In-App Purchases | Pro (non-consumable) + 3 tips (consumable) | Account (same as above) + Paid Apps agreement, tax and bank info | product ids we choose | App Store Connect → app → In-App Purchases | Apple takes 15–30 % | Required if we monetize |
| Google Play Console | Android release + Play Billing | Account | Play developer account | play.google.com/console | 25 USD one-time | Optional (only if Android) |
| RevenueCat (or `in_app_purchase` directly) | Cross-platform purchase handling and restore | API key (public SDK key) | RevenueCat project | revenuecat.com | free up to ~2.5K USD MTR | Optional |
| iOS EventKit / Android CalendarContract | Events and calendars via system accounts | No key; a runtime permission | — | Flutter `device_calendar` plugin | free | **Required** (if we copy minical's architecture) |
| Google Calendar API (direct) | Only if we want in-app Google sign-in (e.g. Android without a system account, web, desktop) | OAuth client ids (iOS/Android/Web) + consent screen; the calendar scope is "sensitive" and needs Google verification | Google Cloud project | console.cloud.google.com → APIs → Calendar API → OAuth | free (verification free; may take weeks) | Optional |
| Microsoft Graph (Outlook) direct | Only if in-app Outlook sync | App registration (client id) | Microsoft Entra / Azure | portal.azure.com → App registrations | free | Optional |
| iCloud / CloudKit | Sync app-local data (custom colors, templates, settings) across devices | iCloud container id in the developer account | CloudKit container | Xcode → Signing & Capabilities → iCloud | free (generous quota) | Optional (recommended) |
| APNs push | **Not needed.** minical's alerts are local notifications. Only needed if we add a server | APNs key (.p8) | Apple Developer → Keys | — | free | Not needed now |
| Firebase (Analytics, Crashlytics) | Analytics + crash reports | Config files (GoogleService-Info.plist, google-services.json) | Firebase project | console.firebase.google.com | free | Optional |
| Sentry (alternative to Crashlytics) | Crash reports | DSN | sentry.io | — | free tier | Optional |
| Google AdMob (+ mediation networks) | Ads in the free tier | AdMob App ID + ad unit ids; each mediation network needs its own account | AdMob account | admob.google.com | free (revenue share) | Optional, depends on our model |
| App Tracking Transparency | Needed only if ads/analytics track | No key; usage string | — | — | free | Optional (with ads) |
| Maps: open in external apps | URL schemes (maps://, comgooglemaps://, waze://, nmap://) | No key | — | — | free | Optional |
| Map preview | MapKit (iOS, no key) or Google Maps SDK (key) / flutter_map + OSM (no key; tile provider terms) | Depends | Google Maps Platform key if used | console.cloud.google.com | free tier / pay as you go | Optional |
| Holiday data | Holiday calendars by country | Depends: Google public holiday ICS feeds (no key), Nager.Date API (no key), Calendarific (key) or a bundled dataset | — | — | free–paid | Optional |
| Link previews | Fetch Open Graph tags | No key (fetch the HTML ourselves) | — | — | free | Optional |
| Domain + website | Privacy policy and support URLs (required by the App Store) | Account | Domain registrar + static hosting (e.g. GitHub Pages) | — | ≈10 USD/year | **Required** (privacy policy URL) |

## Minimum to ship an iOS clone
Apple Developer Program, a Mac with Xcode, an App Group (widgets), IAP products and a privacy policy URL. Everything else is optional.
