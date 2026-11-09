import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../core/time/recurrence.dart';
import 'db/database.dart';
import 'models.dart';

/// The app's event/calendar store. Backed by drift locally (M1); in M8 a device
/// adapter can replace it behind the same surface.
class EventRepository {
  final AppDatabase db;
  final _uuid = const Uuid();

  EventRepository(this.db);

  Stream<List<EventRow>> watchEvents() => db.watchAllEvents();
  Stream<List<Calendar>> watchCalendars() =>
      db.watchCalendars().map((rows) => rows.map(Calendar.from).toList());

  Future<void> save(EventDraft d) async {
    final id = d.id ?? _uuid.v4();
    await db.upsertEvent(EventsCompanion.insert(
      id: id,
      calendarId: d.calendarId,
      title: d.title.trim().isEmpty ? 'Untitled' : d.title.trim(),
      start: d.start,
      end: d.allDay ? _endOfAllDay(d.start, d.end) : d.end,
      allDay: Value(d.allDay),
      colorId: Value(d.colorId),
      location: Value(_nz(d.location)),
      url: Value(_nz(d.url)),
      notes: Value(_nz(d.notes)),
      recFreq: Value(d.recurrence.freq.index),
      recInterval: Value(d.recurrence.interval),
      recEndKind: Value(d.recurrence.endKind.index),
      recUntil: Value(d.recurrence.until),
      recCount: Value(d.recurrence.count),
      alertMinutes: Value(d.alertMinutes),
    ));
  }

  /// Delete an event, keeping a snapshot in the restore cache first.
  Future<void> delete(String id) async {
    final row = await db.findEvent(id);
    if (row != null) {
      await db.insertDeleted(DeletedEventsCompanion.insert(
        id: row.id,
        calendarId: row.calendarId,
        title: row.title,
        allDay: row.allDay,
        start: row.start,
        end: row.end,
        colorId: Value(row.colorId),
        location: Value(row.location),
        url: Value(row.url),
        notes: Value(row.notes),
        recFreq: Value(row.recFreq),
        recInterval: Value(row.recInterval),
        recEndKind: Value(row.recEndKind),
        recUntil: Value(row.recUntil),
        recCount: Value(row.recCount),
        alertMinutes: Value(row.alertMinutes),
        deletedAt: DateTime.now(),
      ));
    }
    await db.deleteEvent(id);
  }

  // --- restore cache ---
  Stream<List<DeletedEventRow>> watchDeleted() => db.watchDeleted();

  Future<void> restore(String id) async {
    final d = await db.takeDeleted(id);
    if (d == null) return;
    await db.upsertEvent(EventsCompanion.insert(
      id: d.id,
      calendarId: d.calendarId,
      title: d.title,
      start: d.start,
      end: d.end,
      allDay: Value(d.allDay),
      colorId: Value(d.colorId),
      location: Value(d.location),
      url: Value(d.url),
      notes: Value(d.notes),
      recFreq: Value(d.recFreq),
      recInterval: Value(d.recInterval),
      recEndKind: Value(d.recEndKind),
      recUntil: Value(d.recUntil),
      recCount: Value(d.recCount),
      alertMinutes: Value(d.alertMinutes),
    ));
  }

  Future<void> restoreAll() async {
    for (final d in await db.allDeleted()) {
      await restore(d.id);
    }
  }

  Future<void> clearDeleted() => db.clearDeleted();

  // --- calendars ---
  Future<void> setCalendarVisible(String id, bool visible) =>
      db.updateCalendar(id, CalendarsCompanion(isVisible: Value(visible)));

  Future<void> setDefaultCalendar(String id) async {
    await db.clearDefaultCalendars();
    await db.updateCalendar(id, const CalendarsCompanion(isDefault: Value(true)));
  }

  /// Create (id == null) or rename/recolour a calendar.
  Future<void> saveCalendar({String? id, required String title, required int colorId}) async {
    final name = title.trim().isEmpty ? 'Calendar' : title.trim();
    if (id == null) {
      final existing = await db.allCalendars();
      final order = existing.isEmpty
          ? 0
          : existing.map((c) => c.displayOrder).reduce((a, b) => a > b ? a : b) + 1;
      await db.upsertCalendar(CalendarsCompanion.insert(
        id: _uuid.v4(),
        title: name,
        colorId: colorId,
        displayOrder: Value(order),
      ));
    } else {
      await db.updateCalendar(
          id, CalendarsCompanion(title: Value(name), colorId: Value(colorId)));
    }
  }

  /// Create a calendar and return its generated id (used by device import).
  Future<String> newCalendar(String title, int colorId) async {
    final id = _uuid.v4();
    final existing = await db.allCalendars();
    final order = existing.isEmpty
        ? 0
        : existing.map((c) => c.displayOrder).reduce((a, b) => a > b ? a : b) + 1;
    await db.upsertCalendar(CalendarsCompanion.insert(
      id: id,
      title: title.trim().isEmpty ? 'Imported' : title.trim(),
      colorId: colorId,
      displayOrder: Value(order),
    ));
    return id;
  }

  /// Delete a calendar and its events.
  Future<void> deleteCalendar(String id) async {
    await db.deleteEventsForCalendar(id);
    await db.deleteCalendar(id);
  }

  Future<void> reorderCalendars(List<String> idsInOrder) async {
    for (var i = 0; i < idsInOrder.length; i++) {
      await db.updateCalendar(idsInOrder[i], CalendarsCompanion(displayOrder: Value(i)));
    }
  }

  /// Create the default calendars on first run. Idempotent. Pass
  /// [withSamples] (dev/tests only) to also seed a few example events; a real
  /// build starts clean with no events.
  Future<void> ensureSeeded({bool withSamples = false}) async {
    if (await db.calendarCount() > 0) return;
    await db.upsertCalendar(CalendarsCompanion.insert(
        id: 'personal', title: 'Personal', colorId: 0,
        isDefault: const Value(true)));
    await db.upsertCalendar(CalendarsCompanion.insert(
        id: 'work', title: 'Work', colorId: 3,
        displayOrder: const Value(1)));

    if (!withSamples) return;

    final today = DateTime.now();
    DateTime at(int dayOffset, int h, [int m = 0]) =>
        DateTime(today.year, today.month, today.day + dayOffset, h, m);

    Future<void> seed(String cal, String title, DateTime s, DateTime e,
        {bool allDay = false, int? color, Recurrence rec = Recurrence.none}) async {
      final d = EventDraft(
        calendarId: cal, title: title, start: s, end: e,
        allDay: allDay, colorId: color, recurrence: rec,
      );
      await save(d);
    }

    await seed('work', 'Standup', at(0, 9, 30), at(0, 9, 45), color: 0,
        rec: const Recurrence(freq: Freq.daily));
    await seed('personal', 'Lunch with Sam', at(0, 13), at(0, 14), color: 5);
    await seed('personal', 'Gym', at(0, 18, 30), at(0, 19, 30), color: 2,
        rec: const Recurrence(freq: Freq.weekly));
    await seed('personal', 'Dentist', at(1, 11), at(1, 11, 45), color: 4);
    await seed('work', 'Design review', at(2, 15), at(2, 16), color: 6);
    await seed('personal', 'Trip to Rome',
        DateTime(today.year, today.month, today.day + 3),
        DateTime(today.year, today.month, today.day + 6),
        allDay: true, color: 1);
  }

  DateTime _endOfAllDay(DateTime start, DateTime end) {
    // all-day events end at the next midnight after their last day
    final last = end.isAfter(start) ? end : start;
    return DateTime(last.year, last.month, last.day).add(const Duration(days: 1));
  }

  String? _nz(String? s) => (s == null || s.trim().isEmpty) ? null : s.trim();
}
