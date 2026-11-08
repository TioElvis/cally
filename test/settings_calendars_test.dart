import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/data/models.dart';
import 'package:cally/data/settings_repository.dart';
import 'package:cally/features/search/search_logic.dart';

void main() {
  late AppDatabase db;
  late EventRepository repo;
  late SettingsRepository settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = EventRepository(db);
    settings = SettingsRepository(db);
  });
  tearDown(() => db.close());

  test('settings default then persist', () async {
    expect((await settings.watch().first).weekStart, DateTime.monday);
    await settings.setThemeMode(ThemePref.dark);
    await settings.setWeekStart(DateTime.sunday);
    await settings.setUse24h(false);
    final s = await settings.watch().first;
    expect(s.themeMode, ThemePref.dark);
    expect(s.weekStart, DateTime.sunday);
    expect(s.use24h, false);
  });

  test('calendar create, default is exclusive, delete removes events', () async {
    await repo.ensureSeeded();
    await repo.saveCalendar(title: 'Fitness', colorId: 2);
    var cals = await repo.watchCalendars().first;
    expect(cals.any((c) => c.title == 'Fitness'), true);

    final fitness = cals.firstWhere((c) => c.title == 'Fitness');
    await repo.setDefaultCalendar(fitness.id);
    cals = await repo.watchCalendars().first;
    expect(cals.where((c) => c.isDefault).length, 1);
    expect(cals.firstWhere((c) => c.isDefault).id, fitness.id);

    // deleting the 'personal' calendar removes its events too
    final before = (await db.watchAllEvents().first).where((e) => e.calendarId == 'personal');
    expect(before.isNotEmpty, true);
    await repo.deleteCalendar('personal');
    final after = (await db.watchAllEvents().first).where((e) => e.calendarId == 'personal');
    expect(after.isEmpty, true);
  });

  test('visibility toggle persists', () async {
    await repo.ensureSeeded();
    await repo.setCalendarVisible('work', false);
    final cals = await repo.watchCalendars().first;
    expect(cals.firstWhere((c) => c.id == 'work').isVisible, false);
    expect(cals.firstWhere((c) => c.id == 'personal').isVisible, true);
  });

  test('search matches title/location/notes and filters by calendar', () async {
    await repo.ensureSeeded();
    final rows = await db.watchAllEvents().first;
    expect(matchEvents(rows, query: '').isEmpty, true); // empty query → nothing
    expect(matchEvents(rows, query: 'standup').length, 1);
    expect(matchEvents(rows, query: 'STANDUP').length, 1); // case-insensitive
    // Standup is on the 'work' calendar
    expect(matchEvents(rows, query: 'standup', calendarId: 'personal').isEmpty, true);
    expect(matchEvents(rows, query: 'standup', calendarId: 'work').length, 1);
  });
}
