# 05 — Widgets

> The widget list and sizes come from minical's widget guide [STORE]. Only the **large "This Month"** widget was captured (light mode, default theme) [USAGE]. Everything else stays [STORE]/[INFERRED] until more screenshots arrive.
>
> ⚠️ **Note for the Flutter build:** iOS widgets, lock screen accessories, Watch complications and Control Center controls **cannot be written in Flutter**. They must be native **SwiftUI + WidgetKit** extensions (Watch: a watchOS target; controls: `ControlWidget`, iOS 18+). Flutter shares data with them through an **App Group** (e.g. the `home_widget` package). On Android the equivalents are Glance/AppWidget, written in Kotlin. Building all of this needs macOS + Xcode, so it cannot happen on Arch Linux.

## Home screen widgets [STORE]
Grid units: small 1×1 (2×2 icons), medium 2×1, large 2×2, extra large 4×2 (iPad only).

| # | Widget | Small | Medium | Large | XL (iPad) | Contents (expected) |
|---|---|---|---|---|---|---|
| 1 | Calendar | ✓ (+StandBy) | | | | Mini month grid; today marked; optional underline on days with events |
| 2 | Upcoming Events | ✓ (+StandBy) | ✓ | ✓ | | Next N events from now: date, time, color, title |
| 3 | Today | ✓ | | | | Today's date + today's events |
| 4 | Today & Calendar | | ✓ | | | Left: today's events; right: mini month [INFERRED split] |
| 5 | Events & Calendar | | ✓ | | | Upcoming list + mini month [INFERRED] |
| 6 | Two Months | | ✓ | | | Two mini month grids side by side |
| 7 | Three Days | | ✓ | | | 3 columns (today + 2), events listed per day |
| 8 | This Week | | ✓ | | | 7 columns with event titles |
| 9 | Two Weeks | | ✓ | | | 2 week rows with event titles |
| 10 | Three Weeks | | | ✓ | ✓ | 3 week rows |
| 11 | Four Weeks | | | ✓ | ✓ | 4 week rows (rolling, starting this week) |
| 12 | This Month | | | ✓ | ✓ | Full month grid with event titles |
| 13 | Next Month | | | ✓ | ✓ | Same, next month |
| 14 | Last Month | | | ✓ | ✓ | Same, previous month |

The App Store says 21 types on iPhone and 26 on iPad (counting size variants plus lock screen widgets). [STORE]

## Observed: "This Month" — large [USAGE] (IMG_7582)
- **Container:** white background (default theme, light mode) with the standard system widget corner radius. The app name label sits under it.
- **Header:** the **full month name, uppercase, bold** (~18–20 pt), top-left. This differs from the app header, which uses the abbreviation. No year, no buttons.
- **Weekday row:** single uppercase letters, Monday first, Sunday letter red.
- **Grid:** 6 rows × 7 columns including the previous and next months' days (light grey numbers, faded events). Saturday numbers grey, Sunday/holiday red, today highlighted with a light grey rounded cell fill. There is **no selected-day** state.
- **Event chips:** the same style as the app (2 pt color bar + 20 % tinted background + darkened text), one line, clipped. Multi-day events span cells as one bar.
- **Overflow:** a cell with more events than fit shows **2 chips + a grey "+2"** counter. Widget cells fit fewer chips than the app's 4.
- Font sizes are slightly smaller than in the app; layout and colors match the app exactly, so the widget probably reuses the app's grid renderer. [INFERRED]
- Tap targets: unknown (needs testing: tap a day vs. an event vs. the header).

## Lock screen widgets [STORE]
| Widget | Position | Family [INFERRED] | Contents |
|---|---|---|---|
| Upcoming Events | below the time | rectangular | next 2–3 events |
| Two Weeks | below the time | rectangular | 14-day mini grid with event marks |
| Next Event | below the time **or** above it (inline) | rectangular / inline | next event time + title |
| New Event | below the time | circular | "+" button → opens the new event editor (`minical://new`) |

## Apple Watch complications [STORE]
Upcoming Events, Next Event, Today. Families: TBD (circular / rectangular / corner / inline).

## Control Center / Action button controls (iOS 18) [STORE]
Open App · New Event · Search Events.

## Configuration [STORE]
- Edit Widget (long-press) options vary by widget. Expected options [INFERRED]: which calendars to show, start day, show past events, maybe theme.
- Background and text colors follow the app's color theme and light/dark mode. No photo or transparent backgrounds.
- Event text size follows the app setting for some widgets.

## Interactions [INFERRED, to verify]
- Tap a day in a grid widget → the app opens on that date (deep link).
- Tap an event → opens that event.
- Tap empty space → opens the app on today.
- "New Event" accessory → new event editor.
- No interactive (iOS 17 button) widgets are advertised.

## Refresh behavior [STORE][INFERRED]
- Timeline-based. The app reloads widgets when events change (EventKit change notification) and at midnight / day change.
- iOS can delay updates. The official advice is to open the app, disable Low Power Mode, or show fewer calendars, which suggests timelines are rebuilt when the app runs and that heavy calendars hit the widget memory/time budget.
- Our build should add timeline entries at each event start/end and at midnight, and call `WidgetCenter.reloadAllTimelines()` after every edit in the app.
