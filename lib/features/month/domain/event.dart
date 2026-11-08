import '../../../core/time/month_grid.dart';

/// Minimal event model for the month view (M0, mock data). In M1 this maps to
/// the local drift store; in M8 to device_calendar. UI never depends on either.
class Event {
  final String id;
  final String title;
  final DateTime start;
  final DateTime end;
  final bool allDay;
  final int colorId; // index into EventColors.palette
  final String calendarId;

  const Event({
    required this.id,
    required this.title,
    required this.start,
    required this.end,
    required this.colorId,
    this.allDay = false,
    this.calendarId = 'mock',
  });

  /// True if the event covers [day] (any overlap with that calendar day).
  bool occursOn(DateTime day) {
    final d0 = dateOnly(day);
    final d1 = d0.add(const Duration(days: 1));
    return start.isBefore(d1) && end.isAfter(d0);
  }

  bool get isMultiDay => !isSameDay(start, end.subtract(const Duration(seconds: 1)));
}
