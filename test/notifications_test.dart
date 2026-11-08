import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/recurrence.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/data/models.dart';
import 'package:cally/features/notifications/notification_plan.dart';

void main() {
  late AppDatabase db;
  late EventRepository repo;
  final now = DateTime(2026, 11, 10, 8, 0); // fixed "now"

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = EventRepository(db);
  });
  tearDown(() => db.close());

  Future<List<EventRow>> rows() => db.watchAllEvents().first;

  test('per-event alert produces one notification before the start', () async {
    await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
    await repo.save(EventDraft(
      calendarId: 'c', title: 'Dentist',
      start: DateTime(2026, 11, 10, 11), end: DateTime(2026, 11, 10, 12),
      alertMinutes: 30,
    ));
    final plan = planNotifications(events: await rows(), settings: const AppSettings(), now: now);
    expect(plan.length, 1);
    expect(plan.first.title, 'Dentist');
    expect(plan.first.when, DateTime(2026, 11, 10, 10, 30));
    expect(plan.first.body, '30 minutes before');
  });

  test('default alert is used when an event has none', () async {
    await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
    await repo.save(EventDraft(
      calendarId: 'c', title: 'Meeting',
      start: DateTime(2026, 11, 10, 15), end: DateTime(2026, 11, 10, 16),
    ));
    expect(planNotifications(events: await rows(), settings: const AppSettings(), now: now), isEmpty);
    final withDefault = planNotifications(
        events: await rows(),
        settings: const AppSettings(defaultAlertTimed: 10),
        now: now);
    expect(withDefault.length, 1);
    expect(withDefault.first.when, DateTime(2026, 11, 10, 14, 50));
  });

  test('a daily recurring alert schedules one per day within the horizon', () async {
    await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
    await repo.save(EventDraft(
      calendarId: 'c', title: 'Standup',
      start: DateTime(2026, 11, 10, 9, 30), end: DateTime(2026, 11, 10, 9, 45),
      alertMinutes: 0, recurrence: const Recurrence(freq: Freq.daily),
    ));
    final plan = planNotifications(
        events: await rows(), settings: const AppSettings(), now: now, horizonDays: 5);
    expect(plan.length, 5);
    expect(plan.every((p) => p.title == 'Standup'), true);
  });

  test('morning digest counts the day\'s events', () async {
    await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
    await repo.save(EventDraft(
        calendarId: 'c', title: 'A',
        start: DateTime(2026, 11, 10, 12), end: DateTime(2026, 11, 10, 13)));
    await repo.save(EventDraft(
        calendarId: 'c', title: 'B',
        start: DateTime(2026, 11, 10, 14), end: DateTime(2026, 11, 10, 15)));
    final plan = planNotifications(
      events: await rows(),
      settings: const AppSettings(digestMorningOn: true, digestMorningMin: 9 * 60),
      now: now, horizonDays: 1,
    );
    final digest = plan.where((p) => p.title == 'Today');
    expect(digest.length, 1);
    expect(digest.first.body, '2 events today');
    expect(digest.first.when, DateTime(2026, 11, 10, 9, 0));
  });

  test('delete snapshots to the restore cache; restore brings it back', () async {
    await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
    await repo.save(EventDraft(
        calendarId: 'c', title: 'Trip',
        start: DateTime(2026, 11, 12), end: DateTime(2026, 11, 13)));
    final id = (await rows()).single.id;

    await repo.delete(id);
    expect(await rows(), isEmpty);
    expect((await repo.watchDeleted().first).length, 1);

    await repo.restore(id);
    expect((await rows()).length, 1);
    expect(await repo.watchDeleted().first, isEmpty);
  });

  test('clearDeleted empties the cache', () async {
    await db.upsertCalendar(CalendarsCompanion.insert(id: 'c', title: 'C', colorId: 0));
    await repo.save(EventDraft(
        calendarId: 'c', title: 'X',
        start: DateTime(2026, 11, 12, 9), end: DateTime(2026, 11, 12, 10)));
    await repo.delete((await rows()).single.id);
    await repo.clearDeleted();
    expect(await repo.watchDeleted().first, isEmpty);
  });
}
