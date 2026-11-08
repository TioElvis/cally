# 02 — Features

Legend: **F** = free, **P** = Pro only, **?** = unknown. Source tags are explained in README.

## 1. Calendar views
| Feature | Tier | Source |
|---|---|---|
| Month grid with event titles inside day cells | F | [STORE] |
| Selected-day event list under the grid | F | [STORE] |
| Jump to any month or year with a date picker (wheel modal + "Done") | F | [STORE] |
| Swipe between months | F | [STORE] FAQ "move to another month" [INFERRED gesture] |
| "Today" shortcut | F | [INFERRED] |
| Dim past events | F? | [STORE] |
| Show or hide event colors in the grid | F | [STORE] |
| Week numbers | **P** | [STORE] |
| Holiday highlighting; Saturday/Sunday highlighting | F | [STORE] |
| Lunar dates (KR, CN, HK, MO, TW, VN, MY, SG only) | F | [STORE] |
| Traditional/regional calendar dates | F | [STORE] |
| No week/day/agenda timeline view is advertised | — | [INFERRED] verify in screenshots |

## 2. Events
| Feature | Tier | Source |
|---|---|---|
| Create, view and edit with one tap | F | [STORE] |
| Title, all-day, start/end, duration picker (e.g. "1 hour") | F | [STORE] |
| Time entry with 1-minute steps (FAQ topic, so the default step is coarser) | F | [STORE] |
| Calendar (category) picker | F | [STORE] |
| Per-event color, overriding the calendar color | F | [STORE] |
| Multiple alerts per event (relative, all-day "on the day at 9:00", custom) | F | [STORE] |
| Recurrence: daily/weekly/monthly/yearly, intervals, "4th Thursday of the month" style rules, end repeat | F | [STORE] |
| Location with map preview; open in Apple Maps, Google Maps, Naver Map or Waze | F | [STORE] |
| URL field with website thumbnail preview | F | [STORE] |
| Notes | F | [STORE] |
| Show attendees (read-only; you cannot add attendees, per FAQ) | F | [STORE] |
| "Join" button for Zoom, Google Meet, Teams, Webex links | F | [STORE] |
| Input suggestions from past event titles | F | [STORE] |
| Event templates | F: up to 2 / **P**: unlimited | [STORE] |
| Default settings for new events (calendar, duration, alerts) | F | [STORE] |
| Copy an event to another date | F | [STORE] |
| Copy an event to **multiple** dates at once | **P** | [STORE] |
| Move an event to another date (FAQ; probably by editing the date, maybe drag) | F | [STORE] [INFERRED how] |
| Context menu on an event: delete, copy, share | F | [STORE] |
| Share an event as text through the iOS share sheet | F | [STORE] |
| Delete with confirmation; recurring delete asks "this / future events" | F | [INFERRED] |
| Restore deleted events from the local cache ("Restore Events": Restore / Restore All / Delete All) | F | [STORE] |

## 3. Calendars and accounts
| Feature | Tier | Source |
|---|---|---|
| Show any iOS calendar account: iCloud, Google, Outlook/Exchange, Naver, other CalDAV | F | [STORE] |
| Accounts are added in **iOS Settings**, not inside the app | F | [STORE] |
| Toggle which calendars are visible | F | [STORE] |
| Reorder calendars (drag handles); the order controls event order in cells | F | [STORE] |
| Create, edit and delete calendars: name, color grid, account ("Save to Apple Calendar"), alerts on/off per calendar | F | [STORE] |
| Choose a default calendar | F | [STORE] |
| Warning card when the default calendar is local-only (no cloud backup) | F | [STORE] |
| Holiday calendars by country (searchable list, event counts) | F | [STORE] |
| Birthdays calendar (from Contacts) | F | [STORE] |
| Shared calendars (through iCloud/Google/Outlook sharing; no own backend) | F | [STORE] |
| Notion Calendar (through Google) | F | [STORE] |
| Option not to sync with the iOS Calendar app (help guide "Do not sync") | F | [STORE] [INFERRED: a local calendar] |

## 4. Search
| Feature | Tier | Source |
|---|---|---|
| Keyword search over past and future events | F | [STORE] |
| Date range filter | F | [STORE] |
| Filter by calendar source (floating filter menu) | F | [STORE] |

## 5. Notifications and badge
| Feature | Tier | Source |
|---|---|---|
| Local alerts per event (EventKit alarms and/or local notifications) | F | [STORE] |
| Separate default alerts for timed and all-day events | F | [STORE] |
| Turn off alerts for a whole calendar | F | [STORE] |
| Daily digest at a chosen time (today's events), plus an optional evening "tomorrow" digest | F | [STORE] |
| 7 notification sounds | F | [STORE] |
| App icon badge: today's date / week number / today's event count / none | F | [STORE] |
| Event count can exclude all-day, completed, or no-alert events | F | [STORE] |
| "Preview" button to test a notification | F | [STORE] |

## 6. Appearance and personalization
| Feature | Tier | Source |
|---|---|---|
| 38 color themes (light and dark variants) | F: 3 / **P**: all | [STORE] |
| Dark mode follows the system | F | [STORE] |
| 10 fonts for month name, weekdays and dates | F: default / **P**: all | [STORE] |
| 21 alternate app icons | F: 2 / **P**: all | [STORE] |
| First day of the week | F | [STORE] |
| Highlight holidays / Saturday / Sunday | F | [STORE] |
| Calendar language (month/weekday names) | F | [STORE] |
| Underline dates that have events (small widgets) | F | [STORE] |
| Event text size, month grid | F | [STORE] |
| Event text size, day list | F | [STORE] |
| Bold event text | F | [STORE] |
| 12h / 24h time | F | [STORE] |
| Time zone override | F | [STORE] |
| App language: English or "system settings" | F | [STORE] |
| Live calendar preview at the top of the Appearance screen | F | [STORE] |

## 7. Widgets and system integration (details in 05-widgets.md)
| Feature | Tier | Source |
|---|---|---|
| 21 widget types on iPhone, 26 on iPad (home + lock screen) | F | [STORE] |
| StandBy support | F | [STORE] |
| Apple Watch app + 3 complications | F | [STORE] |
| Control Center / Action button controls: Open app, New event, Search | F | [STORE] |
| Siri Shortcuts / App Intents | F | [STORE] |
| Focus mode filter (show certain calendars per Focus) | F | [STORE] [INFERRED behavior] |
| URL scheme `minical://` and `minical://new` | F | [STORE] |
| iOS 18 system app lock (Face ID) works with it; no lock built into the app | — | [STORE] |

## 8. Onboarding, support and other
| Feature | Tier | Source |
|---|---|---|
| Onboarding: choose week start + text size with a live preview, then the notification, calendar and tracking (ATT) permission prompts | F | [STORE] |
| "Settings assistant" with status cards (permissions, calendar access, etc.) | F | [STORE] |
| In-app feedback form (text, Cancel/Send) + help links | F | [STORE] |
| Rating prompt (5-star dialog; "write a review") | F | [STORE] |
| About: support, other apps, legal, version, share the app | F | [STORE] |
| Tips (Candy / Donut / Pizza sizes) | IAP | [STORE] |
| Ads shown in free version | F | [STORE] |
| Accessibility: VoiceOver, Dynamic Type (≥200%), dark interface | F | [STORE] |

## Free vs Pro summary [STORE]
| | Free | Pro |
|---|---|---|
| Ads | yes | none |
| Event templates | 2 | unlimited |
| Color themes | 3 | 38 |
| Fonts | default | 10 |
| App icons | 2 | 21 |
| Copy to multiple dates | no | yes |
| Week numbers | no | yes |
| Everything else (widgets, sync, alerts, search) | yes | yes |
