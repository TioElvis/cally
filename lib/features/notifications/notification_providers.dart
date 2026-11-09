import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/month_grid.dart';
import '../../data/models.dart';
import '../../l10n/app_localizations.dart';
import '../month/month_providers.dart';
import 'notification_plan.dart';
import 'notification_service.dart';

final notificationServiceProvider =
    Provider<NotificationService>((ref) => createNotificationService());

/// Keeps scheduled notifications and the app badge in sync with events +
/// settings. Kept alive by watching it from the month page.
final notificationSchedulerProvider = Provider<void>((ref) {
  final service = ref.watch(notificationServiceProvider);

  Future<void> reschedule() async {
    final events = ref.read(eventRowsProvider).value ?? const [];
    final settings = ref.read(settingsProvider).value ?? const AppSettings();
    final now = DateTime.now();

    await service.replaceAll(planNotifications(
        events: events, settings: settings, now: now, t: _deviceL10n()));

    final badge = switch (settings.badgeType) {
      BadgeType.count => countOnDay(events, dateOnly(now)),
      BadgeType.date => now.day,
      BadgeType.none => 0,
    };
    await service.setBadge(badge);
  }

  ref.listen(eventRowsProvider, (_, _) => reschedule());
  ref.listen(settingsProvider, (_, _) => reschedule());
  reschedule();
});

/// AppLocalizations for the device language, for background notification text.
AppLocalizations _deviceL10n() {
  final device = WidgetsBinding.instance.platformDispatcher.locale;
  final supported =
      AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
  final code = supported.contains(device.languageCode) ? device.languageCode : 'en';
  return lookupAppLocalizations(Locale(code));
}
