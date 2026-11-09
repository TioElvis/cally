import 'package:flutter/cupertino.dart';

/// Design tokens for Cally. See docs/DESIGN.md.
///
/// Base UI colours come from dynamic [CupertinoColors] so light/dark adapt
/// automatically; only the brand accent and the event palette are our own.
class Tokens {
  Tokens._();

  // Default brand accent (teal). The user can pick another from [kAccents];
  // the chosen one is applied as the Cupertino theme's primaryColor, so widgets
  // read `CupertinoTheme.of(context).primaryColor`.
  static const brand = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF0D9488),
    darkColor: Color(0xFF2DD4BF),
  );
  // Text/number drawn on top of the accent (white in light, near-black in dark),
  // chosen to stay readable for every accent in [kAccents].
  static const onBrand = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFF0A0A0A),
  );

  // Spacing
  static const gutterEdge = 8.0; // grid runs near edge-to-edge
  static const gutter = 16.0; // headings / buttons
  static const gap = 8.0;

  // Grid
  static const gridRows = 6;
  static const gridCols = 7;
  static const rowHeight = 78.0;

  // Radii
  static const rCell = 10.0;
  static const rChip = 3.0;
  static const rButton = 12.0;
  static const rPill = 999.0;
  static const rSheet = 24.0;

  // Tap target
  static const minTap = 44.0;

  // Motion
  static const fast = Duration(milliseconds: 180);
  static const base = Duration(milliseconds: 280);
  static const slow = Duration(milliseconds: 420);
  static const curve = Curves.easeOutCubic;
}

/// The event colour palette (8 original hues) and the three-tone derivation
/// every chip uses: a solid bar, a tinted background and darkened/lightened text.
class EventColors {
  EventColors._();

  static const palette = <Color>[
    Color(0xFF5B6CF0), // indigo
    Color(0xFF19B6A6), // teal
    Color(0xFF34B759), // green
    Color(0xFFF5A623), // amber
    Color(0xFFFF7A45), // orange
    Color(0xFFEC4E8C), // pink
    Color(0xFFA05BF0), // purple
    Color(0xFF64748B), // slate
  ];

  static Color base(int colorId) => palette[colorId % palette.length];

  /// Returns (bar, background, text) resolved for the current brightness and
  /// surface. [faded] dims the whole chip for out-of-month days.
  static ChipTones of(
    BuildContext context,
    int colorId, {
    bool faded = false,
  }) {
    final dark = CupertinoTheme.brightnessOf(context) == Brightness.dark;
    final surface = CupertinoColors.systemBackground.resolveFrom(context);
    final b = base(colorId);
    final bg = Color.alphaBlend(b.withValues(alpha: dark ? 0.26 : 0.16), surface);
    final text = dark ? _lighten(b, 0.35) : _darken(b, 0.45);
    final opacity = faded ? 0.45 : 1.0;
    return ChipTones(
      bar: b.withValues(alpha: opacity),
      background: faded ? bg.withValues(alpha: 0.6) : bg,
      text: text.withValues(alpha: opacity),
    );
  }

  static Color _darken(Color c, double amount) =>
      HSLColor.fromColor(c).withLightness(
        (HSLColor.fromColor(c).lightness * (1 - amount)).clamp(0.0, 1.0),
      ).toColor();

  static Color _lighten(Color c, double amount) {
    final hsl = HSLColor.fromColor(c);
    return hsl
        .withLightness((hsl.lightness + (1 - hsl.lightness) * amount).clamp(0.0, 1.0))
        .toColor();
  }
}

class ChipTones {
  final Color bar;
  final Color background;
  final Color text;
  const ChipTones({required this.bar, required this.background, required this.text});
}

/// A selectable app accent (used for the selected day, Today pill and links).
class Accent {
  final String name;
  final CupertinoDynamicColor color;
  const Accent(this.name, this.color);
}

/// The accent palette the user can choose from. Index 0 (Teal) is the default.
const kAccents = <Accent>[
  Accent('Teal', CupertinoDynamicColor.withBrightness(
      color: Color(0xFF0D9488), darkColor: Color(0xFF2DD4BF))),
  Accent('Indigo', CupertinoDynamicColor.withBrightness(
      color: Color(0xFF5B6CF0), darkColor: Color(0xFF8B97FF))),
  Accent('Blue', CupertinoDynamicColor.withBrightness(
      color: Color(0xFF2563EB), darkColor: Color(0xFF60A5FA))),
  Accent('Purple', CupertinoDynamicColor.withBrightness(
      color: Color(0xFF7C3AED), darkColor: Color(0xFFA78BFA))),
  Accent('Pink', CupertinoDynamicColor.withBrightness(
      color: Color(0xFFDB2777), darkColor: Color(0xFFF472B6))),
  Accent('Orange', CupertinoDynamicColor.withBrightness(
      color: Color(0xFFEA580C), darkColor: Color(0xFFFB923C))),
  Accent('Green', CupertinoDynamicColor.withBrightness(
      color: Color(0xFF059669), darkColor: Color(0xFF34D399))),
  Accent('Graphite', CupertinoDynamicColor.withBrightness(
      color: Color(0xFF334155), darkColor: Color(0xFF94A3B8))),
];

CupertinoDynamicColor accentColor(int id) =>
    kAccents[id < 0 || id >= kAccents.length ? 0 : id].color;
