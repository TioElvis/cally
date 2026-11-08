import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'features/month/month_page.dart';

void main() {
  runApp(const ProviderScope(child: CalApp()));
}

class CalApp extends StatelessWidget {
  const CalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cally',
      debugShowCheckedModeBanner: false,
      theme: buildCupertinoTheme(),
      home: const MonthPage(),
    );
  }
}
