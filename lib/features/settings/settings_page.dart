import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../data/models.dart';
import '../calendars/calendars_page.dart';
import '../month/month_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final repo = ref.read(settingsRepositoryProvider);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: const CupertinoNavigationBar(middle: Text('Settings')),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('Appearance'),
              children: [
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
                  trailing: CupertinoSwitch(
                    value: settings.use24h,
                    onChanged: repo.setUse24h,
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('Calendars'),
              children: [
                CupertinoListTile(
                  title: const Text('Manage calendars'),
                  leading: const Icon(CupertinoIcons.circle_grid_3x3),
                  trailing: const CupertinoListTileChevron(),
                  onTap: () => Navigator.of(context).push(
                    CupertinoPageRoute(builder: (_) => const CalendarsPage()),
                  ),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('About'),
              children: const [
                CupertinoListTile(title: Text('Cally'), additionalInfo: Text('M2 · local')),
              ],
            ),
          ],
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
    // 2024-01-01 is a Monday (weekday 1).
    final date = DateTime(2024, 1, 1).add(Duration(days: weekday - 1));
    return DateFormat('EEEE').format(date);
  }
}
