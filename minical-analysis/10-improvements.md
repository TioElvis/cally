# 10 — Improvements

Our own ideas for how Cally improves on minical. These feed the milestone roadmap
in `docs/PLAN.md`.

## Decided
- **No ads, no tracking.** Cally monetizes only with a **one-time Pro** unlock
  (plus optional tips) — never ads, never an ad/analytics SDK. This lets us ship
  an App Store **"Data not collected"** privacy label, which is the headline
  differentiator over minical's ads + IDFA + Firebase stack. (Decided 2026-11-08.)

## Proposed (to confirm)
- **Android is first-class.** minical is iOS-only; Cally ships the same polished
  iOS-style experience on Android from day one (one Flutter codebase).
- **Quick-add with natural language** in the editor — e.g. "lunch fri 1pm" fills
  title, date, time and duration.
- **Optional week / agenda view** alongside the month grid + day list
  (open question #1 in `11-open-questions.md`).
- **Drag an event to another day** directly on the grid (open question #4).

## Parking lot (later / maybe)
- Natural cross-device sync of app-local data (custom colours, templates,
  settings) — M5.
- Richer accessibility defaults than minical (large-type month layout that keeps
  event titles readable).
