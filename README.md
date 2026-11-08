# Cally

A minimalist, native-feeling **month-grid calendar** for iPhone and Android, built
in Flutter. Inspired by the genre documented in `minical-analysis/` — our own name,
design, icons and code.

See [`docs/PLAN.md`](docs/PLAN.md) for architecture and the roadmap, and
[`docs/DESIGN.md`](docs/DESIGN.md) for the design system.

## Status
**M7 — Cally Pro** (local): a one-time Pro entitlement with a paywall and a purchase port (local unlock for dev; real IAP deferred to M8). Pro gates **week numbers** in the month grid (ISO 8601), with locks on gated controls that open the paywall. No ads, no tracking. Built on M0–M6.
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
