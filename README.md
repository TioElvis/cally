# Cally

A minimalist, native-feeling **month-grid calendar** for iPhone and Android, built
in Flutter. Inspired by the genre documented in `minical-analysis/` — our own name,
design, icons and code.

See [`docs/PLAN.md`](docs/PLAN.md) for architecture and the roadmap, and
[`docs/DESIGN.md`](docs/DESIGN.md) for the design system.

## Status
**M6 — sharing** (local): share any event out as readable text or as a standard **.ics** file (iCalendar with RRULE), via a long-press actions menu on agenda rows (Share text / Share .ics / Edit / Delete), behind a share port. Built on M0–M5.
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
