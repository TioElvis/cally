import '../../l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/tokens.dart';
import '../../core/time/formats.dart';
import '../../data/models.dart';
import '../backup/backup_page.dart';
import '../calendars/calendars_page.dart';
import '../month/month_providers.dart';
import '../notifications/notification_providers.dart';
import '../notifications/restore_page.dart';

const _alertOptions = <int?>[null, 0, 5, 10, 15, 30, 60, 120];

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final t = AppLocalizations.of(context);
    final repo = ref.read(settingsRepositoryProvider);
    final use24h = settings.use24h;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(middle: Text(t.settings)),
      child: SafeArea(
        child: ListView(
          children: [
            // --- Appearance ---
            CupertinoListSection.insetGrouped(
              header: Text(t.appearance),
              children: [
                CupertinoListTile(
                  title: Text(t.weekNumbers),
                  trailing: CupertinoSwitch(
                    value: settings.showWeekNumbers,
                    onChanged: repo.setShowWeekNumbers,
                  ),
                ),
                CupertinoListTile(
                  title: Text(t.theme),
                  trailing: SizedBox(
                    width: 220,
                    child: CupertinoSlidingSegmentedControl<ThemePref>(
                      groupValue: settings.themeMode,
                      children: {
                        ThemePref.system: Text(t.system),
                        ThemePref.light: Text(t.light),
                        ThemePref.dark: Text(t.dark),
                      },
                      onValueChanged: (v) {
                        if (v != null) repo.setThemeMode(v);
                      },
                    ),
                  ),
                ),
                CupertinoListTile(
                  title: Text(t.firstDayOfWeek),
                  additionalInfo: Text(_weekdayName(settings.weekStart)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickWeekStart(context, repo, settings.weekStart),
                ),
                CupertinoListTile(
                  title: Text(t.use24h),
                  trailing: CupertinoSwitch(value: settings.use24h, onChanged: repo.setUse24h),
                ),
                _AccentRow(selected: settings.accentId, onPick: repo.setAccent),
              ],
            ),

            // --- Notifications ---
            CupertinoListSection.insetGrouped(
              header: Text(t.notifications),
              children: [
                CupertinoListTile(
                  title: Text(t.enableNotifications),
                  leading: const Icon(CupertinoIcons.bell),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _requestPermission(context, ref),
                ),
                CupertinoListTile(
                  title: Text(t.defaultAlert),
                  additionalInfo: Text(_alertLabel(t, settings.defaultAlertTimed)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickAlert(context, settings.defaultAlertTimed,
                      (m) => repo.setDefaultAlertTimed(m)),
                ),
                CupertinoListTile(
                  title: Text(t.defaultAlertAllDay),
                  additionalInfo: Text(_alertLabel(t, settings.defaultAlertAllDay)),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => _pickAlert(context, settings.defaultAlertAllDay,
                      (m) => repo.setDefaultAlertAllDay(m)),
                ),
                CupertinoListTile(
                  title: Text(t.morningDigest),
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
                  title: Text(t.eveningDigest),
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
                  title: Text(t.appIconBadge),
                  trailing: SizedBox(
                    width: 200,
                    child: CupertinoSlidingSegmentedControl<BadgeType>(
                      groupValue: settings.badgeType,
                      children: {
                        BadgeType.none: Text(t.badgeNone),
                        BadgeType.date: Text(t.badgeDate),
                        BadgeType.count: Text(t.badgeCount),
                      },
                      onValueChanged: (v) {
                        if (v != null) repo.setBadgeType(v);
                      },
                    ),
                  ),
                ),
                CupertinoListTile(
                  title: Text(t.restoreEvents),
                  leading: const Icon(CupertinoIcons.arrow_counterclockwise),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => const RestorePage())),
                ),
              ],
            ),

            // --- Calendars ---
            CupertinoListSection.insetGrouped(
              header: Text(t.calendars),
              children: [
                CupertinoListTile(
                  title: Text(t.manageCalendars),
                  leading: const Icon(CupertinoIcons.circle_grid_3x3),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => const CalendarsPage())),
                ),
              ],
            ),

            CupertinoListSection.insetGrouped(
              header: Text(t.data),
              children: [
                CupertinoListTile(
                  title: Text(t.backupRestore),
                  leading: const Icon(CupertinoIcons.square_arrow_up_on_square),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (_) => const BackupPage())),
                ),
              ],
            ),

            CupertinoListSection.insetGrouped(
              header: Text(t.about),
              children: [
                CupertinoListTile(title: const Text('Cally'), additionalInfo: Text(t.localFree)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _requestPermission(BuildContext context, WidgetRef ref) async {
    final granted = await ref.read(notificationServiceProvider).requestPermission();
    if (!context.mounted) return;
    final t = AppLocalizations.of(context);
    showCupertinoDialog<void>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(granted ? t.notificationsEnabled : t.notificationsOff),
        content: Text(granted
            ? t.notificationsOnMsg
            : t.notificationsOffMsg),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(c),
              child: Text(t.ok)),
        ],
      ),
    );
  }

  Future<void> _pickAlert(
      BuildContext context, int? current, ValueChanged<int?> onPick) async {
    final t = AppLocalizations.of(context);
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: Text(t.defaultAlert),
        actions: _alertOptions
            .map((m) => CupertinoActionSheetAction(
                  onPressed: () {
                    onPick(m);
                    Navigator.pop(c);
                  },
                  child: Text(_alertLabel(t, m)),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: Text(t.cancel)),
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
                      child: Text(AppLocalizations.of(context).done, style: const TextStyle(fontWeight: FontWeight.w600)),
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
    final t = AppLocalizations.of(context);
    const options = [DateTime.monday, DateTime.sunday, DateTime.saturday];
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: Text(t.firstDayOfWeek),
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
            onPressed: () => Navigator.pop(c), child: Text(t.cancel)),
      ),
    );
  }

  static String _weekdayName(int weekday) {
    final date = DateTime(2024, 1, 1).add(Duration(days: weekday - 1));
    return DateFormat('EEEE').format(date);
  }

  static String _alertLabel(AppLocalizations t, int? minutes) {
    if (minutes == null) return t.alertNone;
    if (minutes == 0) return t.atTimeOfEvent;
    if (minutes % 60 == 0) return t.hoursBefore(minutes ~/ 60);
    return t.minutesBefore(minutes);
  }

  static String _hhmm(int minutesFromMidnight, bool use24h) =>
      fmtTime(DateTime(2000, 1, 1, minutesFromMidnight ~/ 60, minutesFromMidnight % 60), use24h);
}

class _AccentRow extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onPick;
  const _AccentRow({required this.selected, required this.onPick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Text(AppLocalizations.of(context).accentColor),
          ),
          Wrap(
            spacing: 14,
            runSpacing: 12,
            children: List.generate(kAccents.length, (i) {
              final c = kAccents[i].color.resolveFrom(context);
              final isSel = selected == i;
              return GestureDetector(
                onTap: () => onPick(i),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: c,
                    shape: BoxShape.circle,
                    border: isSel
                        ? Border.all(color: CupertinoColors.label.resolveFrom(context), width: 2.5)
                        : null,
                  ),
                  child: isSel
                      ? const Icon(CupertinoIcons.check_mark, size: 16, color: CupertinoColors.white)
                      : null,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
