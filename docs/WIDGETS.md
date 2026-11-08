# Home-screen widgets (M4)

Widgets are **native** (iOS WidgetKit / Android AppWidget) — they can't be
written in Flutter. Cally's Dart side computes the data and hands it to the
widgets through the `home_widget` plugin; the native views just render it.

## Data flow

```
events + settings (drift)
   └─ widgetRefresherProvider  (reschedules on every change)
        └─ buildWidgetPayload()  →  Map<String,String>  (pure, tested)
             └─ HomeWidgetBridge.publish()
                  ├─ FakeHomeWidgetBridge   (Linux/dev/tests: records)
                  └─ HomeWidgetAdapter      (iOS/Android: App Group + updateWidget)
                       └─ native widgets read title/grid/upcoming/todayCount
```

Payload keys (`lib/features/widgets/widget_payload.dart`):
- `title` — current month name, uppercase.
- `grid` — JSON of 42 cells `{d, out, today, dots:[colorId…], more}`.
- `upcoming` — JSON of the next events `{t, s(msEpoch), c, a}`, chronological.
- `todayCount` — events today.

## Taps / deep links

`parseDeepLink(Uri)` maps `cally://today`, `cally://day/<yyyy-mm-dd>`,
`cally://new[/<date>]` to an action; the month page handles widget taps via
`home_widget` (`initiallyLaunchedFromHomeWidget` / `widgetClicked`).

## Native source

- **iOS:** `ios/CallyWidget/CallyWidget.swift` — WidgetKit bundle (Month +
  Upcoming). Add the target + App Group in Xcode (see `docs/BUILD-IOS.md`).
- **Android:** `android/app/src/main/kotlin/com/cally/cally/CallyWidgetProvider.kt`
  + `res/layout/cally_widget.xml` + `res/xml/cally_widget_info.xml`, registered
  in `AndroidManifest.xml`. Build and test on an emulator/device.

## Status

The Dart pipeline (payload, bridge, deep links, refresh-on-change) is complete
and unit-tested on Linux. The native widgets are committed but must be **built
and visually verified on a Mac (iOS) and an Android emulator** — that can't
happen on the Linux dev machine. The Android widget currently shows a compact
summary (title + today count + next event); a full RemoteViews month grid is a
later refinement.
