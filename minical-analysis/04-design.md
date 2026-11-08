# 04 — Design

Measured from screenshots at 3× (1170×2532 px → 390×844 pt) [USAGE]. Colors were sampled from pixels. Sizes are approximate (±1–2 pt). Light mode, default theme, free version only. **Our app must use its own palette, fonts and icons.** The values describe minical's look and are not meant to be copied verbatim.

## Principles [USAGE]
- **Typographic, not boxy.** No grid lines, no card shadows on the main screen, no navigation bar background. Structure comes from type size, weight and whitespace.
- **Black/white/grey base, color only for events** (plus red for Sundays/holidays and blue for Pro).
- **Big, confident headings**: a huge month abbreviation and a large bold date heading.
- **Capsules and rounded rectangles** for every control (pills, chips, buttons, sheets).
- **Bottom sheets** for every secondary screen (editor, search, date picker).

## Color (default light theme) [USAGE]
| Role | Value | Notes |
|---|---|---|
| Background | `#FFFFFF` | app, sheets, widget |
| Primary text / icons | `#1A1A1A` | near-black, not pure black |
| Secondary text (Saturday numbers) | `#8C8C8C` | |
| Disabled / outside-month numbers | `#BABABA` | |
| Placeholder text | `#C5C5C7` | title placeholder, empty fields |
| Row icons in editor | `#484848` | |
| Sunday / holiday | `#EF5350` | a soft red, used for the weekday letter and date numbers |
| Today cell fill | `#EEEEEF` | very light grey |
| Selected cell fill | `#313131` | near-black, number in white |
| Button / chip fill (secondary) | `#F4F4F5` | New event, template button, picker buttons, suggestion chip |
| Primary action (Save) | `#262627` fill, white text | dark capsule |
| Scrim behind sheets | ≈ black at 20 % (white page → `#CBCBCB`) | |
| Pro accent | `#0079FF` badge; card fill `#EDF6FF` with a thin light-blue border | |

### Event colors [USAGE]
Observed calendar/event colors look like a Material-400-style palette: purple `#AB47BC`, pink `#EC407A`, bright blue `#0088FE`, lavender `#9A9CFE`, orange, green, black. **Every chip derives three tones from one base color:**
| Part | Rule (measured) |
|---|---|
| Left bar | base color, 100 % |
| Chip background | base color at **≈ 20 % opacity** over white (e.g. pink → `#FAD9E4`) |
| Chip text | base color **darkened ≈ 50 %** (e.g. blue `#0088FE` → text `#00447F`) |
| Outside-month events | the whole chip at ≈ 40 % opacity |

## Typography [USAGE]
The UI uses the system sans-serif (SF Pro) at the default font setting. The 10 selectable fonts apply only to the month name, weekday letters and dates [STORE].
| Element | Size (pt, approx.) | Weight | Case |
|---|---|---|---|
| Month in header ("NOV") | ~38–40 | regular/medium | UPPERCASE, abbreviated |
| Weekday letters | ~11 | medium | UPPERCASE single letter |
| Date numbers in grid | ~16 | regular | — |
| Event chip text | ~10 | regular | as typed |
| Selected-date heading | ~24 | bold | sentence case, includes year |
| "New event" button label | ~17 | regular | — |
| Large sheet title ("Search") | ~34 | bold | — |
| Editor title placeholder | ~28–30 | bold | — |
| Editor time ("16:00") | ~22 | bold | — |
| Editor date over time | ~15 | regular | — |
| Chips / pills in editor | ~15–16 | regular | — |
| Save button | ~17 | semibold | — |
| Widget month name ("NOVEMBRE") | ~18–20 | bold | UPPERCASE, full name |

## Layout and spacing [USAGE]
| Element | Value |
|---|---|
| Screen side margin (headings, buttons) | ~8 pt (the grid runs almost edge to edge) |
| Header height | ~60 pt below the status bar |
| Grid columns | screen width / 7 ≈ 56 pt |
| Grid row height | ~80 pt fixed, 6 rows always |
| Event chip | height ~11 pt, line pitch ~13 pt, horizontal inset ~2 pt, corner ~2 pt |
| Chip left bar | ~2 pt wide, full chip height |
| Today / selected cell highlight | full cell, corner radius ~9–10 pt |
| "New event" button | height ~55 pt, corner ~10 pt, ~80 % width |
| Template button | ~58×55 pt, same style |
| Today pill (header) | ~61×21 pt capsule, 1.5 pt dark outline, icon + uppercase label |
| Bottom sheets | top corner radius ~25 pt; grabber 32×4 pt `#C4C4C6` |
| Date picker buttons | two equal buttons, height ~50 pt, corner ~12 pt, ~16 pt gap |
| Search field | capsule, height ~35 pt, light grey fill |
| Close button (search) | ~44 pt white circle with a soft, wide shadow |
| Save button | floating capsule ~105×46 pt, dark, soft shadow, bottom-right with ~20 pt margin |
| Editor rows | icon column ~16 pt glyph at x≈20 pt, content at x≈55 pt, vertical gap ~45 pt between groups |

## Icons [USAGE]
SF Symbols-style **line icons**, regular weight, near-black: magnifier, calendar-with-dots grid, gear, return arrow (in the Today pill), clock, circular arrow (repeat), calendar (calendar picker), bell (alerts), document (templates), "…" (more), × (close), three-line filter. Our app should use an equivalent open set (e.g. Lucide or Material Symbols Outlined).

## Components to build
1. **EventChip** (base color → bar / 20 % bg / 50 % dark text; single line; clip; optional spanning across cells)
2. **DayCell** (number + chips; states: normal, Saturday, Sunday/holiday, outside month, today, selected)
3. **CapsuleButton** (outlined, filled grey, filled dark)
4. **PillChip** (grey capsule with an optional color dot)
5. **BottomSheet** (grabber, large corners, scrim)
6. **WheelPicker** (3 columns)
7. **FloatingSaveButton**
8. **PromoCard** (free tier)

## Motion [INFERRED, not visible in stills]
Sheets slide up with the iOS spring; month change is probably a horizontal page slide. The keyboard opens with the editor and search. A screen recording is still needed.

## Dark mode — not captured
The App Store confirms dark mode, and widgets follow the system appearance [STORE]. Expected mapping: background near-black, selected cell light, chip backgrounds at a higher opacity. **Needs screenshots.**

## Themes — not captured
38 themes change text and background colors and the weekend/holiday highlight colors [STORE]. Only the default theme was captured.

## RTL [INFERRED]
Arabic, Hebrew and Urdu are supported, so the grid order and chevrons should mirror.
