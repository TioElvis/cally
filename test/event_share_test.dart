import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/recurrence.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/data/models.dart';
import 'package:cally/features/share/event_share.dart';

void main() {
  group('eventToText', () {
    test('timed event includes title, time range and location/notes', () {
      final occ = DayOccurrence(
        masterId: 'x', title: 'Lunch', colorId: 0,
        start: DateTime(2026, 11, 10, 13), end: DateTime(2026, 11, 10, 14), allDay: false,
      );
      final t = eventToText(occ, true, location: 'Cafe', notes: 'bring laptop');
      expect(t, contains('Lunch'));
      expect(t, contains('13:00'));
      expect(t, contains('14:00'));
      expect(t, contains('Cafe'));
      expect(t, contains('bring laptop'));
    });

    test('all-day event shows a date, not a time', () {
      final occ = DayOccurrence(
        masterId: 'x', title: 'Holiday', colorId: 0,
        start: DateTime(2026, 12, 25), end: DateTime(2026, 12, 26), allDay: true,
      );
      final t = eventToText(occ, true);
      expect(t, contains('25 Dec'));
      expect(t, isNot(contains(':')));
    });
  });

  group('eventToIcs', () {
    late AppDatabase db;
    late EventRepository repo;
    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = EventRepository(db);
    });
    tearDown(() => db.close());

    Future<EventRow> saveAndRead(EventDraft d) async {
      await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
      await repo.save(d);
      return (await db.watchAllEvents().first).last;
    }

    test('timed recurring event -> valid VEVENT with RRULE, escaped text', () async {
      final row = await saveAndRead(EventDraft(
        calendarId: 'c', title: 'Sprint, planning',
        start: DateTime(2026, 11, 10, 10), end: DateTime(2026, 11, 10, 11),
        notes: 'agenda; goals',
        recurrence: const Recurrence(freq: Freq.weekly, interval: 2, endKind: RecEndKind.count, count: 3),
      ));
      final ics = eventToIcs(row, now: DateTime.utc(2026, 11, 1, 9));
      expect(ics, contains('BEGIN:VEVENT'));
      expect(ics, contains('DTSTART:20261110T100000'));
      expect(ics, contains('DTEND:20261110T110000'));
      expect(ics, contains(r'SUMMARY:Sprint\, planning')); // comma escaped
      expect(ics, contains(r'DESCRIPTION:agenda\; goals')); // semicolon escaped
      expect(ics, contains('RRULE:FREQ=WEEKLY;INTERVAL=2;COUNT=3'));
      expect(ics, contains('\r\n')); // CRLF line endings
    });

    test('all-day event uses VALUE=DATE', () async {
      final row = await saveAndRead(EventDraft(
        calendarId: 'c', title: 'Trip', allDay: true,
        start: DateTime(2026, 12, 24), end: DateTime(2026, 12, 27),
      ));
      final ics = eventToIcs(row);
      expect(ics, contains('DTSTART;VALUE=DATE:20261224'));
      expect(ics, contains('DTEND;VALUE=DATE:'));
      expect(ics, isNot(contains('DTSTART:2026')));
    });
  });
}
