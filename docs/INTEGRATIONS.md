# M8 — Integrations

This milestone connects the (until now fully local) app to external services.
Most of it needs a Mac, real devices, or store accounts, so it can't be verified
on the Linux dev machine. This file records what's wired, what's verified, and
what's blocked.

## Status

| Piece | State | Notes |
|---|---|---|
| **Notification timezone** | ✅ wired, Android-buildable | `flutter_timezone` sets `tz.local` in `LocalNotificationService._init`, so `zonedSchedule` fires at the correct local time (DST-safe). Test the actual firing on a device. |
| **App-icon badge** | ⏳ no-op | `setBadge` still a no-op; needs a platform badge call (iOS `UNUserNotificationCenter`, Android launcher badge) or `flutter_app_badger`. |
| **Real IAP (Pro)** | ✅ adapter committed, ⏳ unverified | `StorePurchaseService` (in_app_purchase) buys/restores the `cally_pro` non-consumable and sets `isPro`. The app still uses `FakePurchaseService` until the store products exist — then point `purchaseServiceProvider` at the real one. |
| **Device calendars (import)** | 🚫 blocked | `device_calendar` 3.9.x declares the removed `jcenter()` repo and **fails the Android build**; 4.x conflicts with our `timezone` 0.11 (needed by flutter_local_notifications). The `DeviceCalendarService` port + fake are in place; the real adapter lands when a compatible release exists, or we fork it / write a thin platform channel. |
| **iCloud / cloud sync transport** | ⏳ pending | The backup JSON (M5) is the payload; transport needs a Mac + Apple account (CloudKit/KV) and an Android mechanism. |

## Wiring the real IAP (when products exist)

1. Create a **non-consumable** product `cally_pro` in App Store Connect and Play
   Console; complete the paid-apps agreements.
2. Swap the provider:
   ```dart
   // lib/features/pro/pro.dart
   final purchaseServiceProvider = Provider<PurchaseService>(
     (ref) => StorePurchaseService(ref.watch(settingsRepositoryProvider)));
   ```
   (Keep the fake behind a debug flag if you still want a dev unlock.)
3. iOS: no extra capability for IAP beyond the paid-apps agreement. Android: the
   `com.android.vending.BILLING` permission is added by the plugin.

## Unblocking device calendars

Pick one when it's time to make the device calendar the source of truth:
- a `device_calendar` release that supports current Gradle **and** `timezone`
  0.11 (watch the changelog), or
- a fork of `device_calendar` with `jcenter()` removed, or
- a thin `MethodChannel` over EventKit (iOS) / CalendarContract (Android) behind
  the existing `DeviceCalendarService` / `CalendarService` surface.

Permissions are already declared: Android `READ_CALENDAR`/`WRITE_CALENDAR` in the
manifest; iOS needs `NSCalendarsFullAccessUsageDescription` in `Info.plist`.

## Keys / accounts

See `docs/KEYS-AND-ACCOUNTS.md`. M8 needs: Apple Developer Program + a Mac
(iOS/widgets/iCloud/IAP), Play Console (Android IAP), and a privacy-policy URL.
No analytics/ad SDKs — Cally stays "Data not collected".
