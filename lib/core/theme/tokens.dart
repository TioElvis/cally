import 'package:flutter/cupertino.dart';

/// Design tokens for Cally. See docs/DESIGN.md.
///
/// Base UI colours come from dynamic [CupertinoColors] so light/dark adapt
/// automatically; only the brand accent and the event palette are our own.
class Tokens {
  Tokens._();

  // Brand accent (Cally teal) — resolves per brightness. Our custom palette
  // colour: used for the selected day, the Today pill and links.
  static const brand = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF0D9488), // teal-600
    darkColor: Color(0xFF2DD4BF), // teal-400
  );
  static const onBrand = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFF07201D),
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
