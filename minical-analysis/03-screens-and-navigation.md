# 03 — Screens and navigation

Sources: 6 screenshots (iPhone 1170×2532 px = 390×844 pt, Italian UI, light mode, free version, iOS 26) [USAGE], plus the App Store listing and the help site [STORE]. Screen names are our own. Screens not covered by the screenshots are marked [STORE]/[INFERRED] and stay open in SCREENSHOT-CHECKLIST.md.

| Screenshot | Shows |
|---|---|
| IMG_7582 | Home screen with the large "This Month" widget |
| IMG_7583 / IMG_7585 | App home: month grid + selected day (near-identical captures) |
| IMG_7584 | Search sheet, empty, keyboard up |
| IMG_7586 | Month/year/day wheel picker sheet |
| IMG_7587 | New event editor sheet, keyboard up |

## Navigation map
```
Launch
 └─ (first run) Onboarding: week start + text size → notification → calendar access → tracking (ATT)   [STORE]
Home (one screen: month grid on top, selected-day section below)                       [USAGE]
 Header:  [MONTH]            [↶ Today pill] [Search] [Month picker] [Settings]          [USAGE]
 ├─ Today pill        → jump back to the current month and select today                [USAGE + INFERRED action]
 ├─ Search icon       → Search sheet (S9)                                               [USAGE]
 ├─ Calendar-grid icon→ Date picker sheet (S3)                                          [USAGE]
 ├─ Gear icon         → Settings (S10)                                                  [USAGE icon] [STORE content]
 ├─ tap a day cell    → selects it; the section below shows that date                   [USAGE]
 ├─ tap an event      → Event detail / editor (S4)                                      [STORE]
 ├─ long-press event  → Context menu: delete / copy / share (S5)                        [STORE]
 ├─ "+ New event" button (below grid) → New event editor sheet (S4)                     [USAGE]
 └─ Template button (document icon, right of New event) → Templates (S7)               [USAGE icon] [INFERRED target]
Settings → Pro paywall, Calendars, Appearance, App icon, Event editing, Notifications & badge,
           Language, Restore events, Settings assistant, Feedback, About                [STORE]
```
**Correction from the draft:** there is **no floating "+" button and no tab bar**. New events start from a wide inline button under the grid. The month picker opens from a calendar icon in the header, not from the title. [USAGE]

---

## S1. Onboarding [STORE] — not captured
Live preview, first-day-of-week picker (modal list), text size controls, a Continue button. Then the system prompts: Notifications → Calendar "full access" → App Tracking Transparency.

## S2. Home — month grid + selected day [USAGE]
Top to bottom:

1. **Header row** (no navigation bar background, sits right under the status bar):
   - Left: **month name, abbreviated and uppercase** (e.g. "NOV"), very large (~38 pt). **No year** is shown in the header.
   - Right, evenly spaced: an outlined **capsule "Today" button** with a return-arrow icon, a **magnifier** (search), a **calendar-grid icon** (date picker) and a **gear** (settings). Icons are black, ~20 pt glyphs.
   - The Today pill may only appear when the selected date isn't today (in the capture the selection was 6 Dec while today was 8 Nov). [INFERRED]
2. **Weekday header:** single uppercase letters following the user's week start (Monday first here). The Sunday letter is red; the others are dark.
3. **Month grid:** always **6 rows × 7 columns**, including spill-over days from the previous and next months.
   - Fixed row height (~80 pt) that fits ~4 event chips. Columns are the full screen width / 7 (~56 pt) with no visible grid lines or borders.
   - **Date number** centered at the top of each cell. Weekdays are near-black; **Saturday** grey; **Sunday and holidays** red. Days outside the month are light grey, and their events are faded too.
   - **Today:** a light grey rounded rectangle fills the whole cell (number red/black as usual).
   - **Selected day:** a **near-black rounded rectangle** filling the whole cell, with the number in white.
   - **Event chips** stack under the number, one line each (see 04-design for the style). Titles are clipped at the cell edge with no ellipsis.
   - **Multi-day events** draw as one continuous chip spanning several cells; the title appears once at the start.
   - **Overflow:** the app grid showed 4 chips in one cell without a "+N". The widget shows "+N" (see 05). Behavior with 5+ events in the app is unknown.
   - Some birthday events show a small cake glyph after the name, probably added for the Birthdays calendar. [INFERRED]
4. **Selected-date heading:** weekday + day + month + **year**, bold, large (~24 pt), left-aligned (e.g. "Sun 6 Dec 2026").
5. **Action row:**
   - A wide light-grey rounded button "+ New event" taking ~80 % of the width.
   - A square light-grey button with a document icon on the right (templates). [INFERRED]
6. **The selected day's event list** goes between the heading and the button, or replaces it [INFERRED]. The captured day had **no events**, and the **empty state is just the heading + the New event button**, with no illustration or message.
7. **Promo/ad slot** at the bottom (free version): a light-blue card with the app icon, a blue "PRO" badge, a bold line about more comfort with Pro and a grey line about removing ads and unlocking features. It sits partly below the fold, so the lower part of the screen scrolls. [USAGE] It's probably a house ad shown in the ad slot when there's no network ad. [INFERRED]

**Gestures:** not visible in stills. Expected: horizontal swipe to change month, vertical scroll of the lower section, long-press on events. [INFERRED] Needs a screen recording.

## S3. Date picker sheet [USAGE]
- A bottom sheet (~60 % of the height) with large top corners. The rest of the screen is dimmed with a light grey scrim; the calendar stays visible behind it.
- **Three wheels: day | month (full name) | year**, with a light grey rounded selection band.
- Two equal buttons at the bottom: **"Today"** (left) and **"Done"** (right). Light grey fill, bold dark text.
- Choosing a date both selects it and shows its month. [INFERRED]

## S4. Event editor — new event [USAGE]
Presented as a **bottom sheet with a grabber** and large top corners, almost full height. The keyboard opens immediately with focus in the title.
- Top-right: **"…" menu** (contents unknown: probably template / copy / delete). [INFERRED]
- **Title field:** very large bold placeholder ("Event name"). A **vertical color bar** on the left takes the selected calendar's color.
- **Input suggestion chip** under the title: a light grey rounded card showing a past event's title and its time range, with that event's color bar. Tapping it presumably fills title/time/calendar from the past event. [USAGE chip] [INFERRED action]
- **Time row** (clock icon): start "weekday day month" (small) over **"16:00"** (large, bold) → chevron → end in the same layout. An **outlined "All-day" capsule** toggle sits on the right.
  - Default: the selected date, start = the current hour rounded down (at 16:32 it proposed 16:00–17:00), **1 h duration**. [USAGE] [INFERRED rounding rule]
- **Repeat row** (circular-arrow icon): grey placeholder "Doesn't repeat".
- **Calendar row** (calendar icon): a capsule chip with a colored dot + calendar name. A Google-account calendar is named after its email address.
- **Alert row** (bell icon): a capsule chip "30 min before" (the default alert from Settings), in grey.
- Further rows hidden under the keyboard: location, URL, notes, color, etc. [STORE]
- **Save:** a floating **dark capsule "✓ Save"** button at the bottom-right, above the keyboard, with a soft shadow. There is no Cancel button; you dismiss by dragging the sheet down. [INFERRED]
- The keyboard return key shows a checkmark (done-style return key).

## S5. Event context menu + share sheet [STORE] — not captured
Long-press: Delete, Copy, Share; Share opens the iOS share sheet.

## S6. Repeat editor [STORE] — not captured
Frequency tabs Day/Week/Month/Year; rules like "every month on the 4th Thursday"; end repeat; Done.

## S7. Templates [STORE] — not captured
Probably opened by the document button next to "New event". Free limit: 2 templates.

## S8. Copy to multiple dates (Pro) [STORE] — not captured

## S9. Search [USAGE]
- A sheet that covers almost the whole screen. A **round white close (×) button with a soft shadow** sits top-right.
- **Large bold title** "Search" (~34 pt), left-aligned.
- **Capsule search field** (light grey fill, magnifier icon) with the placeholder "event name, location and notes". This shows the search covers **title, location and notes**.
- A **filter icon** (three lines of decreasing length) right of the field opens the date/calendar filters. [STORE]
- The keyboard opens automatically. **Empty state is fully blank**, with no recent searches or hints.

## S10–S24. Settings and sub-screens [STORE] — not captured
Same as the draft list: Settings (Pro banner, grouped list), Calendars, Calendar editor, Holidays, Appearance (with live preview), Color themes, App icon, Event editing, Notifications & badge, Language, Restore events (+ empty state), Settings assistant, Feedback, Rating dialog, About.

## S25. Pro paywall [STORE] — not captured
Feature list, social proof, one-time price, Restore Purchases.

## S26. Apple Watch [STORE] — not captured

## Still to capture (most important)
Settings and all its sub-screens, the paywall, a day **with** events (list layout), the editor scrolled down + its "…" menu, the repeat editor, the context menu, a swipe recording, dark mode, onboarding.
