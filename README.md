# Cally

A minimalist, native-feeling **month-grid calendar** for iPhone and Android, built
in Flutter. Inspired by the genre documented in `minical-analysis/` — our own name,
design, icons and code.

See [`docs/PLAN.md`](docs/PLAN.md) for architecture and the roadmap, and
[`docs/DESIGN.md`](docs/DESIGN.md) for the design system.

## Status
**M8 — integrations** (device-pending): the notification timezone is wired (`flutter_timezone`), a real one-time-purchase IAP adapter (`in_app_purchase`) is committed behind the Pro port, and device-calendar import is scaffolded behind a port — currently blocked by the `device_calendar` plugin's Android Gradle incompatibility (see docs/INTEGRATIONS.md). Built on M0–M7.
grid with today + selected-day highlighting, three-tone event chips, multi-day
spans and a selected-day agenda. No external services yet (everything is local;
device calendars, iCloud and purchases come in a later milestone).

## Run it (Linux desktop or Android)
```bash
flutter pub get
flutter run -d linux        # or: flutter run -d <android-device>
```

## Checks
```bash
flutter analyze
flutter test
```

Requires Flutter stable (developed on 3.47.9 / Dart 3.13.7).
