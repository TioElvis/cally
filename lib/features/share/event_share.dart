import '../../core/time/formats.dart';
import '../../core/time/recurrence.dart';
import '../../data/db/database.dart';
import '../../data/models.dart';

/// Human-readable text for sharing a single occurrence (title, when, where…).
String eventToText(DayOccurrence occ, bool use24h, {String? location, String? notes, String? url}) {
  final b = StringBuffer(occ.title);
  b.write('\n');
  if (occ.allDay) {
    final sameDay = occ.end.difference(occ.start).inDays <= 1;
    b.write(sameDay
        ? fmtDate(occ.start)
        : '${fmtDate(occ.start)} – ${fmtDate(occ.end.subtract(const Duration(days: 1)))}');
  } else {
    b.write('${fmtDateTime(occ.start, use24h)} – ${fmtTime(occ.end, use24h)}');
  }
  if (location != null && location.trim().isNotEmpty) b.write('\n📍 ${location.trim()}');
  if (url != null && url.trim().isNotEmpty) b.write('\n🔗 ${url.trim()}');
  if (notes != null && notes.trim().isNotEmpty) b.write('\n${notes.trim()}');
  return b.toString();
}

/// A single-event iCalendar (RFC 5545) document, so the event can be sent to any
/// calendar app. Times are floating local; recurrence maps to an RRULE.
String eventToIcs(EventRow e, {DateTime? now}) {
  final stamp = _dtUtc(now ?? DateTime.now());
  final lines = <String>[
    'BEGIN:VCALENDAR',
    'VERSION:2.0',
    'PRODID:-//Cally//EN',
    'CALSCALE:GREGORIAN',
    'BEGIN:VEVENT',
    'UID:${e.id}@cally',
    'DTSTAMP:$stamp',
    if (e.allDay) ...[
      'DTSTART;VALUE=DATE:${_date(e.start)}',
      'DTEND;VALUE=DATE:${_date(e.end)}',
    ] else ...[
      'DTSTART:${_dtLocal(e.start)}',
      'DTEND:${_dtLocal(e.end)}',
    ],
    'SUMMARY:${_esc(e.title)}',
    if ((e.location ?? '').isNotEmpty) 'LOCATION:${_esc(e.location!)}',
    if ((e.url ?? '').isNotEmpty) 'URL:${_esc(e.url!)}',
    if ((e.notes ?? '').isNotEmpty) 'DESCRIPTION:${_esc(e.notes!)}',
    ..._rrule(recurrenceOf(e), e.allDay),
    'END:VEVENT',
    'END:VCALENDAR',
  ];
  // RFC 5545 uses CRLF line endings.
  return '${lines.join('\r\n')}\r\n';
}

List<String> _rrule(Recurrence r, bool allDay) {
  if (!r.repeats) return const [];
  final freq = switch (r.freq) {
    Freq.daily => 'DAILY',
    Freq.weekly => 'WEEKLY',
    Freq.monthly => 'MONTHLY',
    Freq.yearly => 'YEARLY',
    Freq.none => 'DAILY',
  };
  final parts = <String>['FREQ=$freq'];
  if (r.interval > 1) parts.add('INTERVAL=${r.interval}');
  if (r.endKind == RecEndKind.count && r.count != null) {
    parts.add('COUNT=${r.count}');
  } else if (r.endKind == RecEndKind.until && r.until != null) {
    parts.add(allDay ? 'UNTIL=${_date(r.until!)}' : 'UNTIL=${_dtUtc(DateTime(r.until!.year, r.until!.month, r.until!.day, 23, 59, 59))}');
  }
  return ['RRULE:${parts.join(';')}'];
}

String _two(int n) => n.toString().padLeft(2, '0');
String _date(DateTime d) => '${d.year}${_two(d.month)}${_two(d.day)}';
String _dtLocal(DateTime d) =>
    '${_date(d)}T${_two(d.hour)}${_two(d.minute)}${_two(d.second)}';
String _dtUtc(DateTime d) {
  final u = d.toUtc();
  return '${_date(u)}T${_two(u.hour)}${_two(u.minute)}${_two(u.second)}Z';
}

/// Escape text per RFC 5545 (backslash, comma, semicolon, newline).
String _esc(String s) => s
    .replaceAll('\\', '\\\\')
    .replaceAll(',', '\\,')
    .replaceAll(';', '\\;')
    .replaceAll('\n', '\\n');
