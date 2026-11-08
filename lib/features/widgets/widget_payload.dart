import 'dart:convert';

import '../../core/time/month_grid.dart';
import '../../data/db/database.dart';
import '../../data/models.dart';

/// Builds the data the home-screen widgets render, as a flat String map
/// (home_widget stores primitives). Pure and testable; the native widgets read
/// these keys. Values that are lists/objects are JSON-encoded strings.
///
/// Keys:
///  - `title`    : current month name, uppercase (e.g. "NOVEMBER")
///  - `grid`     : JSON [{d,out,today,dots:[colorId..],more}] × 42 (6×7)
///  - `upcoming` : JSON [{t,s(msEpoch),c,a}] next events (<= [upcomingCount])
///  - `todayCount`: number of events today, as a string
Map<String, String> buildWidgetPayload({
  required List<EventRow> events,
  required Map<String, int> calColor,
  required int weekStart,
  required DateTime now,
  int upcomingCount = 6,
  int horizonDays = 45,
}) {
  final month = firstOfMonth(now);
  final days = monthGridDays(month, weekStart);
  final today = dateOnly(now);

  final from = days.first;
  final to = days.last.add(const Duration(days: 1));
  final occ = expandAll(events, calColor, from, to);

  final grid = <Map<String, dynamic>>[];
  for (final day in days) {
    final onDay = sortOccurrences(occ.where((o) => o.occursOn(day)).toList());
    final dots = onDay.take(3).map((o) => o.colorId).toList();
    grid.add({
      'd': day.day,
      'out': !isSameMonth(day, month),
      'today': isSameDay(day, today),
      'dots': dots,
      'more': onDay.length > 3 ? onDay.length - 3 : 0,
    });
  }

  final horizon = expandAll(events, calColor, now, now.add(Duration(days: horizonDays)));
  // Upcoming is strictly chronological (unlike the agenda's all-day-first order).
  final upcoming = (horizon.where((o) => o.end.isAfter(now)).toList()
        ..sort((a, b) => a.start.compareTo(b.start)))
      .take(upcomingCount)
      .map((o) => {
            't': o.title,
            's': o.start.millisecondsSinceEpoch,
            'c': o.colorId,
            'a': o.allDay,
          })
      .toList();

  final todayCount = occ.where((o) => o.occursOn(today)).length;

  return {
    'title': _monthName(month).toUpperCase(),
    'grid': jsonEncode(grid),
    'upcoming': jsonEncode(upcoming),
    'todayCount': '$todayCount',
  };
}

const _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

String _monthName(DateTime m) => _months[m.month - 1];
