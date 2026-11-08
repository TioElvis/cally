# Cally — Design system

Cally's own look. Inspired by the *genre* documented in `minical-analysis/04-design.md`
(typographic month grid, no boxes, colour only for events) but with **our own
palette, accent, type scale and icons** — nothing copied from minical.

The source of truth is code: `lib/core/theme/tokens.dart` (tokens) and
`app_theme.dart` (Cupertino wiring). This file explains the intent.

## Principles
- **Typographic, not boxy.** No grid lines, no card shadows on the home screen,
  no nav-bar background. Hierarchy from size/weight/whitespace.
- **Monochrome base, colour only for events.** Text/icons use the system label
  colours so light/dark and Dynamic Type come for free.
- **One brand accent** (Cally periwinkle) for the selected day, the Today pill and
  (later) Pro — this is what visually separates Cally from minical's near-black selection.
- **Capsules & rounded rectangles** for every control; **bottom sheets** for
  secondary screens.
- **iOS everywhere.** Cupertino widgets on both iOS and Android; no Material ripples.

## Colour
Base colours are **dynamic `CupertinoColors`** (adapt to light/dark automatically):
`systemBackground`, `label`, `secondaryLabel`, `tertiaryLabel`, `systemGrey*`,
`systemRed` (Sundays/holidays).

Brand + event colours are our tokens:

| Token | Light | Dark | Use |
|---|---|---|---|
| `brand` | `#5B6CF0` | `#8B97FF` | selected day fill, Today pill outline, Pro |
| `onBrand` | `#FFFFFF` | `#0B0B0F` | text on brand fill |
| `todayFill` | systemGrey6 | systemGrey5 | today cell (when not selected) |

**Event palette** (8 original hues; name is internal):
`indigo #5B6CF0 · teal #19B6A6 · green #34B759 · amber #F5A623 · orange #FF7A45 ·
pink #EC4E8C · purple #A05BF0 · slate #64748B`.

Each event chip derives three tones from one base (see `EventColors.of`):
- **bar** = base, full strength.
- **background** = base blended onto the surface at ~16% (light) / ~26% (dark).
- **text** = base darkened ~45% (light) / lightened ~35% (dark).
- outside-month events render the whole chip at ~45% opacity.

## Type scale (relative to Dynamic Type; SF on iOS, fallback on Linux/Android dev)
| Role | Size | Weight | Case |
|---|---|---|---|
| Month header | 34 | w600 | UPPER, abbreviated |
| Selected-day heading | 22 | w700 | sentence |
| Weekday letters | 12 | w600 | UPPER single letter |
| Date number | 15 | w400/w600 today | — |
| Event chip | 11 | w500 | as typed |
| Button / pill | 16 | w500 | — |

Never bundle SF Pro (licensing). On iOS it comes from Cupertino; on Linux/Android
dev we fall back to the platform sans and only approximate the metrics.

## Spacing, radii
- Side gutter **8** (grid runs near edge-to-edge), content gutter **16**.
- Grid: **6 rows × 7 cols**, fixed row height **78**, no borders.
- Radii: cell highlight **10**, chip **3**, pill **999**, button **12**, sheet top **24**.
- Min tap target **44**.

## Motion
- `fast 180ms`, `base 280ms`, `slow 420ms`; curve `easeOutCubic`; sheets use an
  iOS spring. Month paging tracks the finger 1:1 with `BouncingScrollPhysics`
  (rubber-band + velocity on release).
- **Haptics:** `selectionClick` on day select and month change; `mediumImpact` on
  destructive confirm (later).
- **Reduce Motion:** when `MediaQuery.disableAnimations` is true, programmatic
  month jumps are instant (no page animation) and cross-fades replace slides.

## Core components (code in `lib/core/widgets/`)
`EventChip`, `DayCell`, `CapsuleButton`, `PillChip`, plus (later) `BottomSheet`,
`WheelPicker`, `FloatingSaveButton`, `PromoCard`.
