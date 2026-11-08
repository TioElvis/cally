import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/month_grid.dart';
import '../../data/db/database.dart';
import '../../data/event_repository.dart';
import '../../data/models.dart';

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

/// First day of the week (M1: fixed Monday; a setting in M2).
final weekStartProvider = Provider<int>((_) => DateTime.monday);

final calendarsProvider = StreamProvider<List<Calendar>>(
    (ref) => ref.watch(repositoryProvider).watchCalendars());

final eventRowsProvider = StreamProvider<List<EventRow>>(
    (ref) => ref.watch(repositoryProvider).watchEvents());

Map<String, int> _calColor(List<Calendar> cals) =>
    {for (final c in cals) c.id: c.colorId};

/// All occurrences overlapping the 42-day window of [monthAnchor].
final monthOccurrencesProvider =
    Provider.family<List<DayOccurrence>, DateTime>((ref, monthAnchor) {
  final rows = ref.watch(eventRowsProvider).value ?? const [];
  final cals = ref.watch(calendarsProvider).value ?? const [];
  final days = monthGridDays(monthAnchor, ref.watch(weekStartProvider));
  final from = days.first;
  final to = days.last.add(const Duration(days: 1));
  return expandAll(rows, _calColor(cals), from, to);
});

/// Occurrences on a single day, sorted (all-day first, then by start).
final dayOccurrencesProvider =
    Provider.family<List<DayOccurrence>, DateTime>((ref, day) {
  final rows = ref.watch(eventRowsProvider).value ?? const [];
  final cals = ref.watch(calendarsProvider).value ?? const [];
  final from = dateOnly(day);
  final to = from.add(const Duration(days: 1));
  return sortOccurrences(expandAll(rows, _calColor(cals), from, to));
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
