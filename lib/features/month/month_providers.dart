import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/month_grid.dart';
import '../../data/db/database.dart';
import '../../data/event_repository.dart';
import '../../data/models.dart';
import '../../data/settings_repository.dart';

/// The drift database (disposed with the provider scope).
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider =
    Provider<EventRepository>((ref) => EventRepository(ref.watch(databaseProvider)));

/// Seeds default calendars + sample events on first run.
final seedProvider =
    FutureProvider<void>((ref) => ref.watch(repositoryProvider).ensureSeeded());

final settingsRepositoryProvider =
    Provider<SettingsRepository>((ref) => SettingsRepository(ref.watch(databaseProvider)));

final settingsProvider = StreamProvider<AppSettings>(
    (ref) => ref.watch(settingsRepositoryProvider).watch());

AppSettings _settings(Ref ref) =>
    ref.watch(settingsProvider).value ?? const AppSettings();

/// First day of the week, from settings.
final weekStartProvider = Provider<int>((ref) => _settings(ref).weekStart);

/// 24-hour time preference, from settings.
final use24hProvider = Provider<bool>((ref) => _settings(ref).use24h);

/// Theme preference, from settings.
final themePrefProvider = Provider<ThemePref>((ref) => _settings(ref).themeMode);

final calendarsProvider = StreamProvider<List<Calendar>>(
    (ref) => ref.watch(repositoryProvider).watchCalendars());

final eventRowsProvider = StreamProvider<List<EventRow>>(
    (ref) => ref.watch(repositoryProvider).watchEvents());

Map<String, int> _calColor(List<Calendar> cals) =>
    {for (final c in cals) c.id: c.colorId};

/// Only rows whose calendar is currently visible.
List<EventRow> _visibleRows(List<EventRow> rows, List<Calendar> cals) {
  final visible = {for (final c in cals) if (c.isVisible) c.id};
  return rows.where((r) => visible.contains(r.calendarId)).toList();
}

/// All occurrences overlapping the 42-day window of [monthAnchor].
final monthOccurrencesProvider =
    Provider.family<List<DayOccurrence>, DateTime>((ref, monthAnchor) {
  final rows = ref.watch(eventRowsProvider).value ?? const [];
  final cals = ref.watch(calendarsProvider).value ?? const [];
  final days = monthGridDays(monthAnchor, ref.watch(weekStartProvider));
  final from = days.first;
  final to = days.last.add(const Duration(days: 1));
  return expandAll(_visibleRows(rows, cals), _calColor(cals), from, to);
});

/// Occurrences on a single day, sorted (all-day first, then by start).
final dayOccurrencesProvider =
    Provider.family<List<DayOccurrence>, DateTime>((ref, day) {
  final rows = ref.watch(eventRowsProvider).value ?? const [];
  final cals = ref.watch(calendarsProvider).value ?? const [];
  final from = dateOnly(day);
  final to = from.add(const Duration(days: 1));
  return sortOccurrences(
      expandAll(_visibleRows(rows, cals), _calColor(cals), from, to));
});

/// The default calendar for new events.
final defaultCalendarProvider = Provider<Calendar?>((ref) {
  final cals = ref.watch(calendarsProvider).value ?? const [];
  if (cals.isEmpty) return null;
  return cals.firstWhere((c) => c.isDefault, orElse: () => cals.first);
});

/// The month currently centered in the pager (anchored to day 1).
class FocusedMonth extends Notifier<DateTime> {
  @override
  DateTime build() => firstOfMonth(DateTime.now());
  void set(DateTime monthAnchor) => state = firstOfMonth(monthAnchor);
}

final focusedMonthProvider =
    NotifierProvider<FocusedMonth, DateTime>(FocusedMonth.new);

/// The selected day shown in the agenda section.
class SelectedDay extends Notifier<DateTime> {
  @override
  DateTime build() => dateOnly(DateTime.now());
  void set(DateTime day) => state = dateOnly(day);
}

final selectedDayProvider =
    NotifierProvider<SelectedDay, DateTime>(SelectedDay.new);
