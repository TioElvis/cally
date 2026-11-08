import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'data/models.dart';
import 'features/month/month_page.dart';
import 'features/month/month_providers.dart';

void main() {
  runApp(const ProviderScope(child: CalApp()));
}

class CalApp extends ConsumerWidget {
  const CalApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pref = ref.watch(themePrefProvider);
    final brightness = switch (pref) {
      ThemePref.system => null, // follow the platform
      ThemePref.light => Brightness.light,
      ThemePref.dark => Brightness.dark,
    };
    return CupertinoApp(
      title: 'Cally',
      debugShowCheckedModeBanner: false,
      theme: buildCupertinoTheme(brightness),
      home: const MonthPage(),
    );
  }
}
