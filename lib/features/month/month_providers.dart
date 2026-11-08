import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/month_grid.dart';
import 'domain/event.dart';
import 'domain/mock_events.dart';

/// First day of the week (M0: fixed Monday; becomes a setting in M2).
final weekStartProvider = Provider<int>((_) => DateTime.monday);

/// All events (M0: mock data; M1: local store).
final eventsProvider = Provider<List<Event>>((_) => buildMockEvents());

/// Events that occur on a given day, sorted (all-day first, then by start).
final eventsForDayProvider = Provider.family<List<Event>, DateTime>((ref, day) {
  final events = ref.watch(eventsProvider).where((e) => e.occursOn(day)).toList()
    ..sort((a, b) {
      if (a.allDay != b.allDay) return a.allDay ? -1 : 1;
      return a.start.compareTo(b.start);
    });
  return events;
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
