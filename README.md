# Cally

A minimalist, native-feeling **month-grid calendar** for iPhone and Android, built
in Flutter. Inspired by the genre documented in `minical-analysis/` — our own name,
design, icons and code.

See [`docs/PLAN.md`](docs/PLAN.md) for architecture and the roadmap, and
[`docs/DESIGN.md`](docs/DESIGN.md) for the design system.

## Status
**M3 — notifications** (local): per-event and default alerts, morning/evening digests and an app-icon badge, planned from events + settings behind a notification port (real `flutter_local_notifications` on mobile, a fake on Linux/dev). Plus a Restore-events cache (undo deletes). Built on M0–M2.
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
