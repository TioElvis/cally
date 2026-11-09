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
///  - `grid`     : JSON [{d,out,today,labels:[{t,c,a}..],more}] × 42 (6×7)
///  - `upcoming` : JSON [{t,s(msEpoch),c,a}] next events (<= [upcomingCount])
///  - `todayCount`: number of events today, as a string
///
/// Each cell carries up to [labelsPerDay] event labels (title + colour), so the
/// native widgets can render a minical-style grid with small event chips rather
/// than bare dots. Titles are capped so the payload stays small; the widgets
/// ellipsise what does not fit.
Map<String, String> buildWidgetPayload({
  required List<EventRow> events,
  required Map<String, int> calColor,
  required int weekStart,
  required DateTime now,
  int upcomingCount = 6,
  int horizonDays = 45,
  int labelsPerDay = 3,
  int maxTitleChars = 24,
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
    final labels = onDay.take(labelsPerDay).map((o) => {
          't': _cap(o.title, maxTitleChars),
          'c': o.colorId,
          'a': o.allDay,
        }).toList();
    grid.add({
      'd': day.day,
      'out': !isSameMonth(day, month),
      'today': isSameDay(day, today),
      'labels': labels,
      'more': onDay.length > labelsPerDay ? onDay.length - labelsPerDay : 0,
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
    // 1=Mon..7=Sun; the native widgets build their weekday header from this.
    'weekStart': '$weekStart',
  };
}

const _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

String _monthName(DateTime m) => _months[m.month - 1];

/// Trims an event title for the widget, keeping whole characters and adding an
/// ellipsis when cut (the native widgets ellipsise again if the cell is narrow).
String _cap(String s, int max) {
  final t = s.trim();
  if (t.length <= max) return t;
  return '${t.substring(0, max - 1).trimRight()}…';
}
