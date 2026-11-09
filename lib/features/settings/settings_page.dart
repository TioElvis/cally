import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/time/formats.dart';
import '../../data/models.dart';
import '../../core/theme/tokens.dart';
import '../backup/backup_page.dart';
import '../calendars/calendars_page.dart';
import '../integrations/device_calendar_service.dart';
import '../integrations/integrations_providers.dart';
import '../month/month_providers.dart';
import '../notifications/notification_providers.dart';
import '../notifications/restore_page.dart';
import '../pro/pro.dart';
import '../pro/pro_page.dart';

const _alertOptions = <int?>[null, 0, 5, 10, 15, 30, 60, 120];

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final repo = ref.read(settingsRepositoryProvider);
    final use24h = settings.use24h;
    final isPro = ref.watch(isProProvider);

    void openPaywall() => Navigator.of(context)
        .push(CupertinoPageRoute(builder: (_) => const ProPage()));

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
      child: SafeArea(
        child: ListView(
          children: [
            // --- Pro ---
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoListTile(
                  leading: Icon(CupertinoIcons.star_circle_fill,
                      color: Tokens.brand.resolveFrom(context)),
                  title: Text(isPro ? 'Cally Pro' : 'Unlock Cally Pro'),
                  additionalInfo: isPro ? const Text('Active') : null,
                  trailing: const CupertinoListTileChevron(),
                  onTap: openPaywall,
                ),
              ],
            ),

            // --- Appearance ---
            CupertinoListSection.insetGrouped(
              header: const Text('Appearance'),
              children: [
                CupertinoListTile(
                  title: const Text('Week numbers'),
                  additionalInfo: isPro ? null : const Text('Pro'),
                  trailing: isPro
                      ? CupertinoSwitch(
                          value: settings.showWeekNumbers,
                          onChanged: repo.setShowWeekNumbers,
                        )
                      : Icon(CupertinoIcons.lock_fill,
                          size: 18, color: CupertinoColors.tertiaryLabel.resolveFrom(context)),
                  onTap: isPro ? null : openPaywall,
                ),
                CupertinoListTile(
                  title: const Text('Theme'),
                  trailing: SizedBox(
                    width: 220,
                    child: CupertinoSlidingSegmentedControl<ThemePref>(
                      groupValue: settings.themeMode,
                      children: const {
                        ThemePref.system: Text('System'),
                        ThemePref.light: Text('Light'),
                        ThemePref.dark: Text('Dark'),
                      },
                      onValueChanged: (v) {
                        if (v != null) repo.setThemeMode(v);
                      },
                    ),
                  ),
                ),
                CupertinoListTile(
                  title: const Text('First day of week'),
                  additionalInfo: Text(_weekdayName(settings.weekStart)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickWeekStart(context, repo, settings.weekStart),
                ),
                CupertinoListTile(
                  title: const Text('24-hour time'),
                  trailing: CupertinoSwitch(value: settings.use24h, onChanged: repo.setUse24h),
                ),
              ],
            ),

            // --- Notifications ---
            CupertinoListSection.insetGrouped(
              header: const Text('Notifications'),
              children: [
                CupertinoListTile(
                  title: const Text('Enable notifications'),
                  leading: const Icon(CupertinoIcons.bell),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _requestPermission(context, ref),
                ),
                CupertinoListTile(
                  title: const Text('Default alert'),
                  additionalInfo: Text(_alertLabel(settings.defaultAlertTimed)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickAlert(context, settings.defaultAlertTimed,
                      (m) => repo.setDefaultAlertTimed(m)),
                ),
                CupertinoListTile(
                  title: const Text('Default alert (all-day)'),
                  additionalInfo: Text(_alertLabel(settings.defaultAlertAllDay)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickAlert(context, settings.defaultAlertAllDay,
                      (m) => repo.setDefaultAlertAllDay(m)),
                ),
                CupertinoListTile(
                  title: const Text('Morning digest'),
                  additionalInfo:
                      settings.digestMorningOn ? Text(_hhmm(settings.digestMorningMin, use24h)) : null,
                  trailing: CupertinoSwitch(
                    value: settings.digestMorningOn,
                    onChanged: (v) => repo.setMorningDigest(v, settings.digestMorningMin),
                  ),
                  onTap: settings.digestMorningOn
                      ? () => _pickTime(context, settings.digestMorningMin,
                          (m) => repo.setMorningDigest(true, m))
                      : null,
                ),
                CupertinoListTile(
                  title: const Text('Evening digest (tomorrow)'),
                  additionalInfo:
                      settings.digestEveningOn ? Text(_hhmm(settings.digestEveningMin, use24h)) : null,
                  trailing: CupertinoSwitch(
                    value: settings.digestEveningOn,
                    onChanged: (v) => repo.setEveningDigest(v, settings.digestEveningMin),
                  ),
                  onTap: settings.digestEveningOn
                      ? () => _pickTime(context, settings.digestEveningMin,
                          (m) => repo.setEveningDigest(true, m))
                      : null,
                ),
                CupertinoListTile(
                  title: const Text('App icon badge'),
                  trailing: SizedBox(
                    width: 200,
                    child: CupertinoSlidingSegmentedControl<BadgeType>(
                      groupValue: settings.badgeType,
                      children: const {
                        BadgeType.none: Text('None'),
                        BadgeType.date: Text('Date'),
                        BadgeType.count: Text('Count'),
                      },
                      onValueChanged: (v) {
                        if (v != null) repo.setBadgeType(v);
                      },
                    ),
                  ),
                ),
                CupertinoListTile(
                  title: const Text('Restore events'),
                  leading: const Icon(CupertinoIcons.arrow_counterclockwise),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => const RestorePage())),
                ),
              ],
            ),

            // --- Calendars ---
            CupertinoListSection.insetGrouped(
              header: const Text('Calendars'),
              children: [
                CupertinoListTile(
                  title: const Text('Manage calendars'),
                  leading: const Icon(CupertinoIcons.circle_grid_3x3),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => const CalendarsPage())),
                ),
              ],
            ),

            CupertinoListSection.insetGrouped(
              header: const Text('Data'),
              children: [
                CupertinoListTile(
                  title: const Text('Backup & restore'),
                  leading: const Icon(CupertinoIcons.square_arrow_up_on_square),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => const BackupPage())),
                ),
                CupertinoListTile(
                  title: const Text('Import from device calendar'),
                  leading: const Icon(CupertinoIcons.calendar_badge_plus),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _importFromDevice(context, ref),
                ),
              ],
            ),

            CupertinoListSection.insetGrouped(
              header: const Text('About'),
              children: const [
                CupertinoListTile(title: Text('Cally'), additionalInfo: Text('M7 · local')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _importFromDevice(BuildContext context, WidgetRef ref) async {
    final svc = ref.read(deviceCalendarServiceProvider);

    Future<void> info(String title, String msg) async {
      if (!context.mounted) return;
      await showCupertinoDialog<void>(
        context: context,
        builder: (c) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.pop(c),
                child: const Text('OK')),
          ],
        ),
      );
    }

    if (!svc.available) {
      return info('Not available yet',
          'Importing from the device calendar needs the device_calendar plugin, '
          'which is currently incompatible with the Android build (see '
          'docs/INTEGRATIONS.md). It will be enabled in a later update.');
    }
    if (!await svc.ensurePermission()) {
      return info('Permission needed',
          'Allow calendar access to import. On a desktop build there is no device calendar.');
    }
    final cals = await svc.calendars();
    if (!context.mounted) return;
    if (cals.isEmpty) return info('No calendars', 'No device calendars were found.');

    final chosen = await showCupertinoModalPopup<DeviceCal>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: const Text('Import which calendar?'),
        actions: cals
            .map((cal) => CupertinoActionSheetAction(
                  onPressed: () => Navigator.pop(c, cal),
                  child: Text(cal.name),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
    if (chosen == null) return;

    final repo = ref.read(repositoryProvider);
    final targetId = await repo.newCalendar('Imported: ${chosen.name}', 7);
    final now = DateTime.now();
    final n = await svc.importInto(
      repo,
      deviceCalendarId: chosen.id,
      targetCalendarId: targetId,
      from: now.subtract(const Duration(days: 180)),
      to: now.add(const Duration(days: 365)),
    );
    await info('Imported', 'Added $n event${n == 1 ? '' : 's'} from "${chosen.name}".');
  }

  Future<void> _requestPermission(BuildContext context, WidgetRef ref) async {
    final granted = await ref.read(notificationServiceProvider).requestPermission();
    if (!context.mounted) return;
    showCupertinoDialog<void>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(granted ? 'Notifications enabled' : 'Notifications off'),
        content: Text(granted
            ? 'Cally can now remind you about events.'
            : 'Allow notifications in system settings to get alerts.'),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(c),
              child: const Text('OK')),
        ],
      ),
    );
  }

  Future<void> _pickAlert(
      BuildContext context, int? current, ValueChanged<int?> onPick) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: const Text('Default alert'),
        actions: _alertOptions
            .map((m) => CupertinoActionSheetAction(
                  onPressed: () {
                    onPick(m);
                    Navigator.pop(c);
                  },
                  child: Text(_alertLabel(m)),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
  }

  Future<void> _pickTime(
      BuildContext context, int currentMinutes, ValueChanged<int> onPick) async {
    var minutes = currentMinutes;
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => Container(
        height: 300,
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        onPick(minutes);
                        Navigator.pop(context);
                      },
                      child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  use24hFormat: true,
                  initialDateTime:
                      DateTime(2000, 1, 1, currentMinutes ~/ 60, currentMinutes % 60),
                  onDateTimeChanged: (v) => minutes = v.hour * 60 + v.minute,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickWeekStart(BuildContext context, repo, int current) async {
    const options = [DateTime.monday, DateTime.sunday, DateTime.saturday];
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: const Text('First day of week'),
        actions: options
            .map((w) => CupertinoActionSheetAction(
                  onPressed: () {
                    repo.setWeekStart(w);
                    Navigator.pop(c);
                  },
                  child: Text(_weekdayName(w)),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
  }

  static String _weekdayName(int weekday) {
    final date = DateTime(2024, 1, 1).add(Duration(days: weekday - 1));
    return DateFormat('EEEE').format(date);
  }

  static String _alertLabel(int? minutes) {
    if (minutes == null) return 'None';
    if (minutes == 0) return 'At time of event';
    if (minutes % 60 == 0) {
      final h = minutes ~/ 60;
      return '$h hour${h == 1 ? '' : 's'} before';
    }
    return '$minutes minutes before';
  }

  static String _hhmm(int minutesFromMidnight, bool use24h) =>
      fmtTime(DateTime(2000, 1, 1, minutesFromMidnight ~/ 60, minutesFromMidnight % 60), use24h);
}
