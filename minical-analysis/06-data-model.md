# 06 — Data model

## Key architectural fact
minical **does not store events itself**. Events and calendars live in the iOS calendar database (**EventKit**) and sync through the accounts configured in iOS Settings (iCloud, Google, Outlook/Exchange, Naver, CalDAV). The only data the app keeps for itself is local metadata: templates, settings, custom colors, the restore cache and input suggestions. [STORE: backup guide, data-location FAQ, privacy policy]

The model below follows EventKit, because that is what minical can represent. For our Flutter app we can map it to `device_calendar` (iOS EventKit / Android CalendarContract), or build our own store plus sync. That decision goes in 10-improvements.

## Entities

### Account / Source [INFERRED from EventKit]
| Field | Type | Notes |
|---|---|---|
| id | string | |
| title | string | "iCloud", "Gmail address", "On My iPhone" |
| type | enum | local, calDAV (iCloud/Google), exchange, subscribed, birthdays |

### Calendar [STORE + EventKit]
| Field | Type | Notes |
|---|---|---|
| id | string | |
| sourceId | → Account | "save to" account |
| title | string | |
| color | RGB | from the color grid |
| allowsModifications | bool | holidays/birthdays/subscribed are read-only |
| type | enum | local, calDAV, exchange, subscription, birthday |
| isVisible | bool | **app-local** toggle |
| displayOrder | int | **app-local**, drag to reorder |
| alertsEnabled | bool | **app-local**: mute all alerts for this calendar [STORE] |
| isDefault | bool | **app-local** default for new events |

### Event [STORE + EventKit]
| Field | Type | Notes |
|---|---|---|
| id / externalId | string | |
| calendarId | → Calendar | |
| title | string | |
| isAllDay | bool | |
| start, end | datetime | |
| timeZone | tz | there is a timezone setting [STORE] |
| location | string + optional lat/lng (structured location) | map preview |
| url | url | link preview (fetched Open Graph image/title [INFERRED]) |
| notes | text | conference links detected here or in url/location |
| recurrenceRule | → RecurrenceRule | |
| alarms | [Alarm] | multiple |
| attendees | [Attendee] | read-only |
| organizer | Attendee | read-only |
| availability / status | enum | EventKit |
| customColor | RGB? | **app-local**, overrides the calendar color; synced through **iCloud** (likely CloudKit or the iCloud key-value store) keyed by event id [STORE + INFERRED] |
| isCompleted | bool? | badge can exclude "completed" events → some completion state exists [STORE]; storage unknown [INFERRED] |
| conferenceLink | derived | Zoom/Meet/Teams/Webex URL detection |

### RecurrenceRule [STORE + RFC 5545]
| Field | Type | Notes |
|---|---|---|
| frequency | daily / weekly / monthly / yearly | tabs in the repeat editor |
| interval | int | "every 2 weeks" |
| daysOfWeek | [weekday (+ setPos)] | "4th Thursday" |
| daysOfMonth | [int] | |
| monthsOfYear | [int] | |
| setPositions | [int] | |
| end | none / until date / count | "end repeat" |
| occurrence edit scope | this / this and future | when editing or deleting [INFERRED] |

### Alarm [STORE]
| Field | Type | Notes |
|---|---|---|
| relativeOffset | duration | "30 minutes before" |
| absoluteDate | datetime? | all-day: "on the day at 9:00" |
| sound | enum (7) | app-wide setting [STORE] |

### Attendee [STORE: show participants; FAQ: can't add]
name, email, role (required/optional/chair), status (accepted/declined/tentative/pending), isCurrentUser.

### Template [STORE] — app-local
| Field | Notes |
|---|---|
| id, name | |
| title, calendarId, color, isAllDay, duration, startTime?, alarms, location, url, notes, recurrence | a partial event |
| order | |
Limit: 2 free, unlimited Pro.

### InputSuggestion [STORE] — app-local
title (+ the last used calendar/color/duration [INFERRED]), lastUsed, useCount. Can be turned off.

### DeletedEventCache [STORE] — app-local
A snapshot of an event before deletion/change (all Event fields + deletedAt). Actions: restore one, restore all, delete all.

### HolidayCalendar [STORE]
Country/region → list of (date, name). Likely subscribed calendars (Apple/Google public holiday feeds) or a bundled dataset [INFERRED]. Shown in the grid with highlight.

### Birthdays [STORE]
The system Birthdays calendar, built from Contacts. Read-only.

### Settings [STORE] — app-local (shared with widgets through the App Group [INFERRED])
weekStart, highlight{holidays, sat, sun}, themeId, fontId, calendarLanguage, underlineEventDays, eventTextSizeGrid, eventTextSizeList, boldText, showEventColor, showWeekNumbers(P), use24h, showLunar, timeZoneOverride, dimPastEvents, appIconId, defaultCalendarId, defaultDuration, defaultAlarmsTimed, defaultAlarmsAllDay, inputSuggestionsOn, alertSound, digestMorning{on,time}, digestEvening{on,time}, badgeType{none,date,week,count}, badgeExclusions{allDay,completed,noAlarm}, focusFilters, isPro, onboardingDone.

### Entitlement / Purchase [STORE]
productId (pro, tip_small, tip_medium, tip_large — our own ids), purchasedAt, restored.
