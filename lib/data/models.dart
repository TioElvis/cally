import '../core/time/month_grid.dart';
import '../core/time/recurrence.dart';
import 'db/database.dart';

/// A calendar the user can file events under (app-local in M1).
class Calendar {
  final String id;
  final String title;
  final int colorId;
  final bool isDefault;
  const Calendar({
    required this.id,
    required this.title,
    required this.colorId,
    this.isDefault = false,
  });

  factory Calendar.from(CalendarRow r) =>
      Calendar(id: r.id, title: r.title, colorId: r.colorId, isDefault: r.isDefault);
}

/// One concrete occurrence of an event, ready to render. Produced by expanding
/// a stored [EventRow] over a date window.
class DayOccurrence {
  final String masterId;
  final String title;
  final int colorId; // already resolved (event colour or calendar colour)
  final DateTime start;
  final DateTime end;
  final bool allDay;

  const DayOccurrence({
    required this.masterId,
    required this.title,
    required this.colorId,
    required this.start,
    required this.end,
    required this.allDay,
  });

  bool get isMultiDay => !isSameDay(start, end.subtract(const Duration(seconds: 1)));

  bool occursOn(DateTime day) {
    final d0 = dateOnly(day);
    final d1 = d0.add(const Duration(days: 1));
    return start.isBefore(d1) && end.isAfter(d0);
  }
}

Recurrence recurrenceOf(EventRow r) => Recurrence(
      freq: Freq.values[r.recFreq],
      interval: r.recInterval,
      endKind: RecEndKind.values[r.recEndKind],
      until: r.recUntil,
      count: r.recCount,
    );

/// Expand every event's series over [from, to) into day occurrences, resolving
/// each colour against its calendar.
List<DayOccurrence> expandAll(
  List<EventRow> rows,
  Map<String, int> calendarColor,
  DateTime from,
  DateTime to,
) {
  final out = <DayOccurrence>[];
  for (final r in rows) {
    final colorId = r.colorId ?? calendarColor[r.calendarId] ?? 0;
    for (final occ in expand(r.start, r.end, recurrenceOf(r), from, to)) {
      out.add(DayOccurrence(
        masterId: r.id,
        title: r.title,
        colorId: colorId,
        start: occ.start,
        end: occ.end,
        allDay: r.allDay,
      ));
    }
  }
  return out;
}

int _cmp(DayOccurrence a, DayOccurrence b) {
  if (a.allDay != b.allDay) return a.allDay ? -1 : 1;
  return a.start.compareTo(b.start);
}

List<DayOccurrence> sortOccurrences(List<DayOccurrence> xs) => xs..sort(_cmp);

/// Editable form of an event, used by the editor sheet.
class EventDraft {
  String? id;
  String calendarId;
  String title;
  bool allDay;
  DateTime start;
  DateTime end;
  int? colorId;
  String? location;
  String? url;
  String? notes;
  Recurrence recurrence;
  int? alertMinutes;

  EventDraft({
    this.id,
    required this.calendarId,
    this.title = '',
    this.allDay = false,
    required this.start,
    required this.end,
    this.colorId,
    this.location,
    this.url,
    this.notes,
    this.recurrence = Recurrence.none,
    this.alertMinutes,
  });

  factory EventDraft.newAt(DateTime day, String calendarId) {
    final now = DateTime.now();
    final start = DateTime(day.year, day.month, day.day, now.hour + 1);
    return EventDraft(
      calendarId: calendarId,
      start: start,
      end: start.add(const Duration(hours: 1)),
      alertMinutes: 30,
    );
  }

  factory EventDraft.fromRow(EventRow r) => EventDraft(
        id: r.id,
        calendarId: r.calendarId,
        title: r.title,
        allDay: r.allDay,
        start: r.start,
        end: r.end,
        colorId: r.colorId,
        location: r.location,
        url: r.url,
        notes: r.notes,
        recurrence: recurrenceOf(r),
        alertMinutes: r.alertMinutes,
      );
}
