import '../../data/db/database.dart';

/// Pure search over events: matches title/location/notes (case-insensitive),
/// optionally restricted to one calendar, sorted by start. Empty query → no results.
List<EventRow> matchEvents(List<EventRow> rows,
    {required String query, String? calendarId}) {
  final q = query.trim().toLowerCase();
  if (q.isEmpty) return const [];
  final out = rows.where((r) {
    if (calendarId != null && r.calendarId != calendarId) return false;
    return r.title.toLowerCase().contains(q) ||
        (r.location?.toLowerCase().contains(q) ?? false) ||
        (r.notes?.toLowerCase().contains(q) ?? false);
  }).toList()
    ..sort((a, b) => a.start.compareTo(b.start));
  return out;
}
