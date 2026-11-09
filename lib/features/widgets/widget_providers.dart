import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models.dart';
import '../month/month_providers.dart';
import 'home_widget_bridge.dart';
import 'widget_payload.dart';

final homeWidgetBridgeProvider =
    Provider<HomeWidgetBridge>((ref) => createHomeWidgetBridge());

/// Republishes widget data whenever events or settings change. Kept alive by
/// the month page.
final widgetRefresherProvider = Provider<void>((ref) {
  final bridge = ref.watch(homeWidgetBridgeProvider);

  Future<void> refresh() async {
    final rows = ref.read(eventRowsProvider).value ?? const [];
    final cals = ref.read(calendarsProvider).value ?? const <Calendar>[];
    final settings = ref.read(settingsProvider).value ?? const AppSettings();
    // Only visible calendars show in widgets, matching the app.
    final visible = {for (final c in cals) if (c.isVisible) c.id};
    final rowsVisible = rows.where((r) => visible.contains(r.calendarId)).toList();
    final calColor = {for (final c in cals) c.id: c.colorId};

    await bridge.publish(buildWidgetPayload(
      events: rowsVisible,
      calColor: calColor,
      weekStart: settings.weekStart,
      now: DateTime.now(),
      themeMode: settings.themeMode.index,
    ));
  }

  ref.listen(eventRowsProvider, (_, _) => refresh());
  ref.listen(calendarsProvider, (_, _) => refresh());
  ref.listen(settingsProvider, (_, _) => refresh());
  refresh();
});
