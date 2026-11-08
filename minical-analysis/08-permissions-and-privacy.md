# 08 — Permissions and privacy

> The Info.plist could not be read (no bundle), so the exact usage strings are unknown. The permissions below come from the onboarding flow, features and privacy labels.

## iOS permissions
| Permission (Info.plist key) | Why | When asked | Source |
|---|---|---|---|
| Calendars, full access (`NSCalendarsFullAccessUsageDescription`, iOS 17+) | Read/write every event; the core of the app | Onboarding, "Allow Full Access" | [STORE] |
| Notifications (UNUserNotificationCenter: alert, sound, badge) | Event alerts, daily digest, icon badge | Onboarding | [STORE] |
| App Tracking Transparency (`NSUserTrackingUsageDescription`) | Personalized ads (IDFA) | Onboarding, after calendar | [STORE] |
| Contacts (`NSContactsUsageDescription`)? | Contacts appear under "data not linked". Possibly attendee names/photos or birthdays; birthdays can come from the system Birthdays calendar without this permission | unknown | [STORE][INFERRED] |
| Reminders (`NSRemindersFullAccessUsageDescription`)? | "Completed events" in the badge filter could mean reminders/tasks | unknown | [INFERRED] |
| Location when in use? | Privacy label lists coarse location (probably IP-based, from ad SDKs), not GPS | probably never | [INFERRED] |
| Photos? | "Photos or videos" under user content, probably feedback attachments via PHPicker (no permission needed) | unknown | [INFERRED] |
| Siri / App Intents | Shortcuts | none needed for App Intents | [STORE] |
| Focus filters | Show calendars per Focus | none (SetFocusFilterIntent) | [STORE][INFERRED] |

## Expected capabilities / entitlements [INFERRED]
- App Groups: share settings and calendar cache between the app, widgets and Watch.
- iCloud (CloudKit and/or key-value store): custom event colors.
- In-App Purchase.
- Alternate app icons (Info.plist `CFBundleAlternateIcons`, not an entitlement).
- Watch app + WidgetKit extension(s) + intents extension.
- No push notifications (local only), no Sign in with Apple (there are no accounts).
- URL scheme `minical` (`CFBundleURLTypes`). [STORE]
- `LSApplicationQueriesSchemes` for comgooglemaps, waze, nmap, zoomus, msteams, etc. [INFERRED]
- SKAdNetwork identifiers list for the ad networks. [INFERRED]

## Privacy labels (App Store) [STORE]
- **Used to track you:** identifiers, usage data, diagnostics.
- **Linked to you:** coarse location; usage data; user ID; diagnostics; other data.
- **Not linked:** identifiers, usage data, diagnostics, contacts, user content.

## Privacy policy claims [STORE]
- Calendar and contact data stay on the device and never reach minical's servers.
- Analytics: Google Analytics/Firebase, Crashlytics.
- Ads: AdMob + 7 mediation networks. IDFA only with ATT consent.
- No accounts. "Delete account" FAQ: there is nothing to delete.

## Implications for our app
- A free app without ads/tracking could skip ATT entirely and ship a "Data not collected" label. That would be a strong selling point (see 10-improvements).
- Calendar full access is mandatory for the EventKit architecture. Write a clear usage string and a pre-permission explainer screen.
