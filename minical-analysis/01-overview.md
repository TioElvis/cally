# 01 — Overview

## What it is
- A minimalist calendar and planner. The main view is a **monthly grid** that shows event titles inside the day cells, so you can read the whole month at a glance. [STORE]
- It sits on top of the iOS calendar database instead of being a separate system. Any account already in iOS (iCloud, Google, Outlook/Exchange, CalDAV) appears in it automatically. [STORE][INFERRED]
- Widgets are the core selling point: there are many home screen, lock screen, StandBy, Watch and Control Center variants. [STORE]

## Who it's for
- iPhone users who find Apple Calendar's month view too sparse and want event titles visible in the grid. [INFERRED]
- People who care about looks: themes, fonts, app icons. [STORE]
- People with mixed accounts (work Google + personal iCloud) who want one color-coded view. [STORE]
- A strong Japan/Korea/East Asia audience, given lunar calendar support, Naver Map and LINE Ads. [INFERRED]

## Developer
- minical Inc., Japan (App Store developer id 457011383). Older storefronts show an individual developer as copyright holder, so it likely started as a solo project. [STORE]
- First release: 2021-03-26. [STORE]

## Platforms
| Platform | Status | Source |
|---|---|---|
| iPhone | iOS 17.0+ | [STORE] |
| iPad | iPadOS 17.0+, extra large widgets | [STORE] |
| Apple Watch | watchOS 11.0+, app + complications | [STORE] |
| Mac | Apple Silicon only (runs the iPad/iPhone app) | [STORE] |
| Android / Web / Windows | not available (help FAQ "Is there an Android, PC, or web app?") | [STORE] |

## Version analyzed
- **5.12.0**, released 2026-09-30, 114.1 MB (US App Store, checked 2026-11-08). [STORE]
- Recent release notes are generic ("bug fixes and performance improvements") back to at least 5.9.9, so they reveal nothing about features. [STORE]

## Languages (48)
English, Albanian, Amharic, Arabic, Bulgarian, Catalan, Croatian, Czech, Danish, Dutch, Estonian, Finnish, French, German, Greek, Hebrew, Hindi, Hungarian, Icelandic, Indonesian, Irish, Italian, Japanese, Kazakh, Korean, Latvian, Lithuanian, Malay, Malayalam, Norwegian Bokmål, Polish, Portuguese, Romanian, Russian, Serbian, Simplified Chinese, Slovak, Slovenian, Spanish, Swedish, Tamil, Thai, Traditional Chinese, Turkish, Ukrainian, Urdu, Vietnamese, Welsh. [STORE]
- The list includes RTL languages (Arabic, Hebrew, Urdu), so the layout must mirror. [INFERRED]
- There is a separate "calendar language" setting for month and weekday names, independent of the app UI language. [STORE]

## Scale (third-party estimates, not verified)
- ~6.6M installs, ~318K monthly active users, revenue split roughly 62% ads / 38% IAP (AppGoblin). [STORE]
- Rating 4.8 in the US store; 4.75 average worldwide. [STORE]

## How this analysis was done
The plan was to inspect the app bundle. **That was not possible.** This Mac has an Intel Core i5-8210Y (x86_64, macOS 14.8.7), and iOS apps only run on Apple Silicon Macs, so minical cannot be installed here. See `raw/00-host-check.txt`. We used plan B: the App Store listing, minical's public help pages, third-party SDK trackers, and (next) your screenshots.
