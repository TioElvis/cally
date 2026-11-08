# Cally — Plan

A minimalist **month-grid calendar** for **iPhone and Android**, inspired by the
behaviour and genre documented in `minical-analysis/` but built from scratch with
our own name, design, icons and copy. Like minical, events are **not stored by
us**: they live in the device calendar database and sync through the accounts the
user already added to iOS/Android. We keep only app-local metadata.

Scope for now: **iOS (iPhone) + Android**. No iPad-specific, Mac, Web or Windows
targets (the UI still runs on Linux desktop as a dev harness — see below).

---

## 1. Principles

- **Feels like a native Apple app.** Cupertino widgets only (`CupertinoApp`,
  `CupertinoPageScaffold`, `CupertinoSliverNavigationBar`, sheets,
  `CupertinoContextMenu`, `CupertinoIcons`); no visible Material, no ink ripples.
  On Android we keep the same iOS look deliberately (a consistent brand), with
  Material only where the OS demands it (text-field context menus, etc.).
- **Physical motion.** Spring simulations, gestures that track the finger 1:1,
  rubber-banding at edges, velocity preserved on release, `HapticFeedback` on
  commit points. Everything gated behind `MediaQuery.disableAnimations`
  (Reduce Motion) and a settings toggle.
- **Typographic, not boxy.** No grid lines or card shadows on the main screen;
  structure from type scale, weight and whitespace. Black/white/grey base, colour
  only for events. (Our own palette — see `docs/DESIGN.md`, written in step 5.)
- **Native things live behind interfaces.** Anything that needs Xcode/Swift or a
  real device (EventKit, notifications, widgets, purchases) sits behind a Dart
  port with a **fake adapter** so the whole UI runs and is testable on Linux.
- **Accessibility first.** Dynamic Type, `Semantics`/VoiceOver, ≥44pt targets,
  safe areas, light + dark, LTR + RTL.

> Note: the prompt asks to use an **`apple-design` skill**. That skill is **not
> installed in this environment**, so I'm applying the HIG principles listed in
> the prompt directly (springs, interruptible gestures, rubber-banding, velocity,
> haptics, Reduce Motion) plus Apple's current HIG. If you have the skill, point
> me at it and I'll fold it in.

---

## 2. Architecture

**Feature-first + a thin platform layer (ports & adapters).**

```
lib/
  app/                  # CalApp, router, theme wiring, bootstrap
  core/
    theme/              # design tokens, Cupertino theme, text styles, motion
    time/               # date math: month grids, week start, tz, recurrence expansion
    widgets/            # shared UI: EventChip, DayCell, CapsuleButton, PillChip,
                        #   BottomSheet, WheelPicker, FloatingSaveButton, PromoCard
    haptics/ , motion/  # spring helpers, reduce-motion-aware animators
  platform/             # PORTS (abstract) + ADAPTERS (per platform)
    calendar/           # CalendarService  -> DeviceCalendarAdapter | FakeCalendarAdapter
    notifications/      # NotificationService -> LocalNotifAdapter | FakeNotifAdapter
    widgets_bridge/     # HomeWidgetBridge -> HomeWidgetAdapter | NoopAdapter
    purchases/          # PurchaseService -> (later) StoreAdapter | FakePurchaseAdapter
    permissions/        # PermissionGate
  data/
    db/                 # drift database (app-local only)
    repositories/       # EventRepository (wraps CalendarService), SettingsRepository,
                        #   TemplateRepository, CustomColorRepository, SuggestionRepo,
                        #   DeletedCacheRepository
  features/
    month/              # the month view (this session)
    day_agenda/         # selected-day list + empty state
    event_editor/       # create/edit sheet
    search/ settings/ calendars/ onboarding/ paywall/ ...   # later milestones
  l10n/                 # ARB files (it, en)
test/                   # unit (time/recurrence/tz) + widget tests
```

- **State:** Riverpod (`flutter_riverpod` 3.x). Providers expose repositories and
  view-models; the month view watches a `monthProvider(DateTime)`.
- **Which adapter is chosen** is decided at bootstrap from
  `defaultTargetPlatform` / `kIsWeb` / Platform — Linux desktop and tests get the
  fakes; iOS/Android get the real ones. The UI never imports an adapter directly.

### The platform ports (MVP shape)

```dart
abstract class CalendarService {
  Future<PermissionStatus> ensureAccess();
  Future<List<Calendar>> calendars();
  Future<List<Event>> eventsInRange(DateTimeRange r, {Set<String>? calendarIds});
  Future<String> upsert(Event e, {RecurrenceEditScope scope});
  Future<void> delete(String id, {RecurrenceEditScope scope});
  Stream<void> changes();           // EventKit/CalendarContract change notifications
}
```

`FakeCalendarAdapter` seeds a few in-memory calendars and events (mock data for
the month view) and emits `changes()` on edits — so Linux behaves like a device.

---

## 3. Data model

Events and calendars follow the device model (see `minical-analysis/06-data-model.md`)
and are accessed through `device_calendar`; **we never persist them ourselves.**
Our **drift** database stores only app-local metadata:

- `settings` (single row): week start, theme, font, highlights, 24h, default
  calendar/duration/alarms, badge config, digest config, onboardingDone, isPro…
- `templates`, `custom_event_colors` (eventId → colour), `input_suggestions`,
  `deleted_event_cache`, `calendar_prefs` (visibility, order, alertsMuted — the
  app-local overlay on device calendars).

Device-side entities (Account/Source, Calendar, Event, RecurrenceRule, Alarm,
Attendee) are **domain models** mapped from `device_calendar` types, not tables.

---

## 4. Tech stack (verified on pub.dev, 2026-11-08)

| Need | Package | Version | Health |
|---|---|---|---|
| State | `flutter_riverpod` | 3.5.0 | published 2 days ago, active |
| Local DB | `drift` (+ `sqlite3_flutter_libs`, `drift_dev`) | 2.35.3 | 15 days ago, active, runs on Linux too |
| Device calendars | `device_calendar` | 4.3.3 | ⚠ ~2 years since last release (see risk) |
| Local notifications | `flutter_local_notifications` | 23.0.0 | 2 days ago, active, `zonedSchedule` |
| iOS/Android widget bridge | `home_widget` | 0.10.0 | 52 days ago, active |
| i18n | `intl` + `flutter gen-l10n` | current | first-party |
| Routing/deep links | `go_router` | (pin at setup) | for `cally://` deep links from widgets |
| Purchases (later) | `in_app_purchase` or RevenueCat | (M7) | decide at M7 |

Toolchain here: **Flutter 3.47.9 stable / Dart 3.13.7** on Linux.

**Risk — `device_calendar`:** it's the de-facto plugin but its last release is ~2
years old and it pins an older `timezone`. Mitigation: it's fully isolated behind
`CalendarService`, so if it blocks us we can fork it or drop to a thin
platform-channel of our own without touching the app. I'll do a spike at the
start of M1 (real read/write on an Android device) before committing to it.

---

## 5. Platform strategy (Arch Linux dev, no Mac)

- **Linux desktop** + **Android emulator**: full UI with the **fake adapters**;
  identical iOS look. This is the daily dev loop.
- **Android**: real `device_calendar` + `flutter_local_notifications`; Android
  home-screen widget (Glance/AppWidget, Kotlin) in a later milestone.
- **iOS**: builds only on macOS/Xcode (partner's Mac or a cloud macOS runner).
  Native bits (EventKit entitlement, WidgetKit SwiftUI extension, Info.plist
  usage strings) are added there. A **`BUILD-IOS.md`** with exact steps +
  a Codemagic/GitHub-Actions macOS workflow lands when we start iOS-only work.
- iOS widgets / lock-screen / Control Center are **native SwiftUI + WidgetKit**,
  fed through an **App Group** via `home_widget`; they are not Flutter.

---

## 6. Milestone roadmap

- **M0 — Skeleton + design system + Month view (this session).**
  Flutter project, `docs/DESIGN.md` + theme in code, and a polished month view on
  mock data: interruptible spring scrolling between months, today highlighted,
  event indicators, tap a day → that day's agenda. Runs on Linux.
- **M1 — MVP calendar.** `device_calendar` spike; real calendars/events; event
  editor sheet (title, all-day, start/end + duration, calendar, colour, alerts,
  repeat, location text, url, notes); recurrence expansion + edit/delete scope
  (this/future); permission pre-explainer; day agenda with events. Unit tests for
  month-grid math, week start, time zones, recurrence.
- **M2 — Organise & find.** Calendars management (visibility, order, mute,
  create/edit/delete, default), search (title/location/notes + date/calendar
  filters), settings + themes/fonts/first-day/24h, onboarding.
- **M3 — Notifications.** Per-event alerts, default alerts, daily/evening digest,
  sounds, app-icon badge, restore-deleted cache.
- **M4 — Widgets.** iOS WidgetKit (This Month / Upcoming / Today) via App Group;
  Android home widgets; deep links (`cally://`, `cally://new`).
- **M5 — Cross-device sync of app-local data** (iCloud KV/CloudKit on iOS, a
  chosen mechanism on Android) for custom colours, templates, settings.
- **M6 — Sharing** (via the providers' own calendar sharing; share event as text).
- **M7 — Pro** (one-time unlock) — cosmetic + any power features we gate.
  **Decided: no ads, no tracking** — Cally monetizes only with a one-time Pro
  purchase (and optional tips). This is a confirmed product decision, not a default.

### Our improvements (`10-improvements.md` is empty — these are proposals to fill it)
1. **Privacy-first, no ads, no tracking** → ship a "Data not collected" label; use
   it as the headline differentiator over minical.
2. **One codebase, truly cross-platform** (Android is first-class, not absent).
3. **Quick-add with natural language** ("lunch fri 1pm") in the editor.
4. **Optional week / agenda view** (open question #1) alongside month + day list.
5. **Drag an event to another day** on the grid (open question #4).

Confirm/trim these and I'll write them into `10-improvements.md` and the milestones.

---

## 7. Testing

- **Unit:** month-grid generation (6×7, spill-over), week-start (Mon/Sun),
  timezone boundaries & DST, recurrence expansion incl. "4th Thursday", all-day
  handling. Pure Dart, no platform.
- **Widget:** month view renders mock events, swipe changes month, tap selects a
  day, Reduce-Motion path. Golden tests for `EventChip`/`DayCell` light+dark.
- Fakes make all of this run in CI on Linux with no device.

---

## 8. Open decisions (your call at approval)

2. **Monetization** — DECIDED (2026-11-08): one-time **Pro, no ads, no tracking**.

Still to confirm (none block M0):
1. **App name** — "Cally" as working name? Final name/bundle id (`com.<you>.cally`)?
3. **Improvements list** above — which to keep for the roadmap? (captured as
   proposals in `10-improvements.md`)
4. **Android widgets** in M4, or iOS-first and Android widgets later?
5. **`device_calendar`** — ok to commit to it pending the M1 spike, with the
   fork/own-channel fallback noted above?

Nothing here blocks M0. On your approval I'll scaffold the project, write
`docs/DESIGN.md` + the theme, and build the month view.
