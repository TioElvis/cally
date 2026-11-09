# Cally

A minimalist, native-feeling **month-grid calendar** for iPhone and Android, built
in Flutter. Inspired by the genre documented in `minical-analysis/` — our own name,
design, icons and code.

See [`docs/PLAN.md`](docs/PLAN.md) for architecture and the roadmap, and
[`docs/DESIGN.md`](docs/DESIGN.md) for the design system.

## Status
**Current:** fully **local**, fully **free** (no Pro/ads/tracking), custom teal brand, shown as "Cally". Connecting to Apple/Google Calendar is deferred to the future (no API keys yet); the integration port is scaffolded for later. Built on M0–M8 (see docs/).
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
