import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/tokens.dart';
import 'data/models.dart';
import 'features/month/month_page.dart';
import 'features/month/month_providers.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: CalApp()));
}

class CalApp extends ConsumerWidget {
  const CalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pref = ref.watch(themePrefProvider);
    final accent = accentColor(ref.watch(accentProvider));
    final override = ref.watch(localeProvider);
    final brightness = switch (pref) {
      ThemePref.system => null, // follow the platform
      ThemePref.light => Brightness.light,
      ThemePref.dark => Brightness.dark,
    };
    return CupertinoApp(
      title: 'Cally',
      debugShowCheckedModeBanner: false,
      theme: buildCupertinoTheme(brightness, accent),
      // Use the manual override when set, otherwise follow the phone's
      // language automatically (both fall back to English).
      locale: override,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (device, supported) {
        var chosen = const Locale('en');
        if (device != null) {
          for (final s in supported) {
            if (s.languageCode == device.languageCode) {
              chosen = s;
              break;
            }
          }
        }
        // Keep intl's date formatting (month/weekday names) in the same language.
        Intl.defaultLocale = chosen.languageCode;
        return chosen;
      },
      home: const MonthPage(),
    );
  }
}
