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

## CI build (GitHub Actions) — how a friend installs it

`.github/workflows/ios-build.yml` runs on a free macOS runner and, on every push
to `main` (or manually from the **Actions** tab → **iOS build** → **Run
workflow**), produces a downloadable **`Cally-ios-unsigned`** artifact — an
**unsigned `.ipa`**. This needs **no Apple account and no secrets**, exactly like
the Windows build.

> **iOS is not Windows.** A Windows `.zip` just runs; an iOS `.ipa` must be
> *code-signed* to launch on an iPhone. The CI build is unsigned, so your friend
> signs it themselves at install time with their own **free Apple ID**. No paid
> Developer account is required.

### Your friend installs it (free, ~15 min, no jailbreak)

1. On the GitHub **Actions** tab, open the latest **iOS build** run and download
   the **Cally-ios-unsigned** artifact; unzip it to get `Cally-ios-unsigned.ipa`.
2. Install a sideloader on their **computer**:
   - **Windows/macOS:** [Sideloadly](https://sideloadly.io) (simplest), or
   - **AltStore** ([altstore.io](https://altstore.io)) if they want on-device
     auto-refresh.
3. Plug in the iPhone, open the sideloader, drag in the `.ipa`, and sign in with
   their **Apple ID** (an app-specific password may be asked for).
4. On the iPhone: **Settings → General → VPN & Device Management** → trust the
   developer (their Apple ID).
5. Launch Cally.

**Free-account limits (Apple's, not ours):** the app **expires after 7 days** and
must be re-installed/refreshed (AltStore can auto-refresh over Wi-Fi); max 3
sideloaded apps per free Apple ID. A **paid** Developer account removes the 7-day
limit and enables TestFlight (below).

### The home-screen widget is not in the CI build

The CI job builds only the app (the `Runner` target). The **WidgetKit extension**
(`CallyWidget`) must first be added to the Xcode project by hand on a Mac (see
**Add the WidgetKit extension** above) and committed, because its target lives in
`ios/Runner.xcodeproj` which isn't scripted here. Until then the app runs fully;
only the home-screen widget is absent from the sideloaded build.

## Paid distribution (optional, needs an Apple Developer account, $99/yr)

For a signed build / **TestFlight** (no 7-day limit, friend installs from the
TestFlight app): add `flutter build ipa --export-options-plist=...`, and store the
signing certificate, provisioning profile, and App Store Connect API key in the CI
**secret store** (never in git). Codemagic has a turnkey iOS signing flow if you
prefer it over GitHub Actions.
