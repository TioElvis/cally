# 11 — Open questions

## Blocker: no bundle access
minical is **not installed** on this Mac and **cannot be**: the machine has an Intel Core i5-8210Y (x86_64, macOS 14.8.7), and iPhone/iPad apps on Mac need Apple Silicon. Nothing could be tagged [BUNDLE]. Everything that would come from the bundle is unverified:

- [ ] Exact Info.plist permissions and their usage strings
- [ ] Entitlements (App Groups, iCloud container type, Siri, etc.)
- [ ] Bundled frameworks (SDK list comes from AppGoblin + the privacy policy only)
- [ ] Extension list (`PlugIns/*.appex`): how many widget, intent and control extensions
- [ ] Localization strings: the full UI text inventory, every setting label and message
- [ ] Settings.bundle (probably none)
- [ ] URL schemes beyond `minical://` and `minical://new`; widget deep-link format
- [ ] `LSApplicationQueriesSchemes` (which map/conference apps are detected)

**To unblock:** run the same inspection on any Apple Silicon Mac (install from the App Store, then read `/Applications/minical.app/Wrapper/*.app`). Or skip it: the screenshots plus the help site cover most product questions.

## Answered by the first 6 screenshots [USAGE]
- Editor presentation: a **bottom sheet** with a grabber, a floating dark Save capsule and a "…" menu.
- "+" is **not** a floating button: it's an inline "New event" button under the grid, next to a template button.
- The month/year picker opens from a **header calendar icon** as a 3-wheel sheet (day/month/year) with Today/Done.
- Search covers title, location and notes; its empty state is blank.
- The free version shows a Pro promo card at the bottom of the home screen.
- The large widget shows "+N" overflow; the app grid fits ~4 chips per cell.

## Product questions (screenshots can answer)
1. Is there any week/day/agenda view, or only month + day list?
2. Does the day list collapse or expand the grid (a drag handle)? Can the month view scroll vertically?
3. Month change gesture: horizontal swipe, vertical, or arrows?
4. Can events be dragged between days?
5. What does tapping a day twice / long-pressing a day do?
6. Is the editor a sheet or a full screen? Exact field order?
7. Where and in what format do ads appear (banner, native, interstitial)?
8. Onboarding: number of steps, skip option, visuals?
9. What exactly does the "Settings assistant" check?
10. How do themes interact with dark mode (separate dark theme, or auto)?
11. Widget configuration options per widget (calendar filter? start day?)
12. Widget tap behavior (open date vs open event).
13. What is a "completed" event (badge filter)? Is there a checkbox on events?
14. How holiday calendars are sourced (subscribed ICS vs bundled data).
15. "Do not sync with other apps": is this a local-only calendar?
16. Focus filter behavior.
17. Watch app screens.
18. Exact color grid (number of swatches), theme list, font list (names only, as reference for choosing our own).
19. Paywall layout and copy structure (not the text itself).

## Technical decisions for us (not minical questions)
- Architecture: EventKit/CalendarContract via `device_calendar` (like minical, no backend), or our own storage + sync?
- iOS widgets/watch/controls need Swift + Xcode on a Mac. Who builds them, and on which Mac? (This Intel Mac can run Xcode 16 on macOS 14.8 but will be slow; Apple Silicon is recommended.)
- Android target too? If yes, Google sync works through the system account (CalendarContract) with no OAuth key needed.
