import 'package:flutter/cupertino.dart';

import 'tokens.dart';

/// Cupertino theme for Cally. Brightness is left null so it follows the system
/// (light/dark) automatically, and dynamic CupertinoColors resolve per platform
/// brightness. Keeps the iOS system font (SF on iOS; the platform sans elsewhere
/// — we never bundle SF Pro) and our brand accent.
CupertinoThemeData buildCupertinoTheme() {
  return const CupertinoThemeData(
    primaryColor: Tokens.brand,
    applyThemeToAll: true,
  );
}

/// Named text styles, resolved against the current context so colours and
/// Dynamic Type are correct. Sizes follow docs/DESIGN.md.
class AppText {
  AppText._();

  static TextStyle monthHeader(BuildContext c) => TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: CupertinoColors.label.resolveFrom(c),
      );

  static TextStyle dayHeading(BuildContext c) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: CupertinoColors.label.resolveFrom(c),
      );

  static TextStyle weekday(BuildContext c, {Color? color}) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
        color: color ?? CupertinoColors.secondaryLabel.resolveFrom(c),
      );

  static TextStyle dateNumber(BuildContext c,
          {Color? color, bool emphasized = false}) =>
      TextStyle(
        fontSize: 15,
        fontWeight: emphasized ? FontWeight.w700 : FontWeight.w400,
        color: color ?? CupertinoColors.label.resolveFrom(c),
        height: 1.0,
      );

  static const chip = TextStyle(fontSize: 11, fontWeight: FontWeight.w500, height: 1.1);

  static TextStyle pill(BuildContext c, {Color? color}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: color ?? CupertinoColors.label.resolveFrom(c),
      );

  static TextStyle secondary(BuildContext c) => TextStyle(
        fontSize: 15,
        color: CupertinoColors.secondaryLabel.resolveFrom(c),
      );
}
