# Building Cally for iOS (on a Mac)

Cally is developed on Arch Linux, which **cannot build iOS**. iOS builds — and
the WidgetKit extension — are done on a Mac with Xcode (your partner's Mac, or a
cloud macOS runner such as Codemagic / GitHub Actions `macos-latest`).

## One-time setup

1. **Toolchain:** macOS 14.5+, Xcode 16+, CocoaPods, Flutter stable.
2. From the repo root:
   ```bash
   flutter pub get
   cd ios && pod install && cd ..
   open ios/Runner.xcworkspace
   ```
3. **Signing:** Runner target → Signing & Capabilities → your team + a unique
   bundle id (e.g. `com.cally.cally`).

## App Group (required for widgets)

The Flutter app and the widget extension share data through an **App Group**.

1. Runner target → Signing & Capabilities → **+ App Group** →
   `group.com.cally.cally` (must equal `HomeWidgetAdapter.appGroupId` in
   `lib/features/widgets/home_widget_bridge.dart`).
2. Add the **same** App Group to the widget extension target (below).

## Add the WidgetKit extension

The Swift source already exists at `ios/CallyWidget/CallyWidget.swift`; you just
create the target and add the file.

1. Xcode → File → New → Target → **Widget Extension**. Name it **`CallyWidget`**,
   uncheck "Include Configuration Intent", finish, activate the scheme.
2. Delete the template `CallyWidget.swift` Xcode created, then **add the existing**
   `ios/CallyWidget/CallyWidget.swift` to the `CallyWidget` target (Target
   Membership = CallyWidget).
3. Give the `CallyWidget` target the **App Group** `group.com.cally.cally`.
4. Set the extension's deployment target to iOS 17+.

The widget bundle ships two widgets: **Month** (large) and **Upcoming**
(small/medium). They read `title`, `grid`, `upcoming`, `todayCount` from the App
Group; the app writes them via `home_widget` after every change.

## Notifications (M3)

1. Runner → Signing & Capabilities → **+ Push... no** — only enable the
   background modes if needed; local notifications need no capability.
2. `Info.plist`: the permission prompt is requested at runtime
   (`NotificationService.requestPermission`). Add a clear
   `NSUserNotificationsUsageDescription` if the reviewer asks.
3. **Timezone:** the real notification adapter currently defaults to UTC. Before
   shipping, wire the device timezone (add `flutter_timezone`, call
   `tz.setLocalLocation(tz.getLocation(await FlutterTimezone.getLocalTimezone()))`
   in `LocalNotificationService._init`). See the TODO in the adapter.
4. **Badge:** `setBadge` is a no-op today; wire it on device (a small badge call
   or `flutter_app_badger`).

## Deep links / widget taps

Widget taps are delivered by `home_widget` (`initiallyLaunchedFromHomeWidget` /
`widgetClicked`) and routed by `parseDeepLink` → the month page. No URL-scheme
registration is required for widget taps. To also accept external `cally://`
links, add a `CFBundleURLTypes` entry with scheme `cally` to `Info.plist`.

## Build / run

```bash
flutter run -d <ios-device>          # debug on a device
flutter build ipa                    # release archive
```

## CI (optional)

A macOS CI job (Codemagic or GitHub Actions `runs-on: macos-latest`) can:
`flutter pub get` → `pod install` → add the App Group + extension via an Xcode
project step or a committed `.xcconfig` → `flutter build ipa --export-options`.
Keep signing certs and the App Store API key in the CI secret store (never in git).
