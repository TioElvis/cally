# Raw notes from public web sources (plan B)

Collected 2026-11-08. These are paraphrased facts, not copied marketing copy. The bundle could not be inspected (see 00-host-check.txt).

## Sources consulted
| Source | URL | Used for |
|---|---|---|
| App Store (US) | https://apps.apple.com/us/app/id1558953048 | version, size, compatibility, languages, IAPs, privacy labels, feature list |
| minical website | https://minical.app/en/ | widget names (from image file names) |
| minical help index | https://minical.app/en/help | list of 18 guides + 40 FAQ topics |
| Guide: minical pro | https://minical.app/en/guide/minical-pro | free vs Pro table |
| Guide: widget | https://minical.app/en/guide/widget | widget list and sizes, lock screen, Watch, Control widgets |
| Guide: backup | https://minical.app/en/guide/backup | data storage model, Restore Events cache |
| Guide: share calendar | https://minical.app/en/guide/share-calendar | sharing goes through iCloud/Google/Outlook |
| Guide: Google Calendar | https://minical.app/en/guide/google-calendar | Google linked via iOS Settings accounts, not in-app OAuth |
| Guide: Notion Calendar | https://minical.app/en/guide/notion-calendar | goes through Google Calendar |
| Guide: birthday | https://minical.app/en/guide/birthday | Birthdays calendar from Contacts |
| Guide: notification | https://minical.app/en/guide/notification | default alerts, digest, sounds, badge |
| Guide: appearance | https://minical.app/en/guide/appearance | full list of appearance settings |
| FAQ: app lock | https://minical.app/en/faq/app-lock | uses iOS 18 system app lock |
| FAQ: URL scheme | https://minical.app/en/faq/url-scheme | `minical://`, `minical://new` |
| FAQ: remove ads | https://minical.app/en/faq/remove-ad | ads removed by Pro |
| Privacy policy | https://minical.app/en/privacy | third-party SDKs (analytics, crash, ad networks) |
| AppGoblin | https://appgoblin.info/apps/1558953048 | SDK scan, install/revenue estimates |
| ScreensDesign | https://screensdesign.com/apps/minical-planner-calendar/?vs=280072 | screen names and flows from a captured UI library |

## App Store facts (US storefront)
- Name on store: "minical - Planner & Calendar"; subtitle about schedules + widget
- Seller: minical Inc. (Japan); first release 2021-03-26
- Latest version: 5.12.0 (2026-09-30), 114.1 MB
- Requires iOS 17.0+, iPadOS 17.0+, watchOS 11.0+; Mac (Apple Silicon) via iPad/iPhone app
- 48 languages (see 01-overview.md)
- Free + IAP: Pro $11.99 (one-time); tips $0.99 / $3.99 / $9.99
- Rating 4.8 (≈6.2K ratings US); AppGoblin reports 131K ratings worldwide, ~6.6M installs
- Accessibility labels: VoiceOver, Larger Text, Dark Interface
- Age rating 4+, "contains ads"

## Privacy label summary
- Used to track: Identifiers, Usage Data, Diagnostics
- Linked: coarse location, usage, user ID, diagnostics, other data
- Not linked: identifiers, usage, diagnostics, contacts, user content

## SDKs (AppGoblin scan 2026-10-16 + privacy policy)
- Google Firebase (Analytics/GA4, Crashlytics), nanopb (Firebase dependency)
- Google AdMob + mediation: LY/LINE Ads, Pangle, Mintegral, Liftoff (Vungle), InMobi, ironSource, DT Exchange (Digital Turbine)
