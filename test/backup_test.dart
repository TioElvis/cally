import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/recurrence.dart';
import 'package:cally/data/backup_repository.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/data/models.dart';
import 'package:cally/data/settings_repository.dart';

void main() {
  late AppDatabase db;
  late EventRepository repo;
  late SettingsRepository settings;
  late BackupRepository backup;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = EventRepository(db);
    settings = SettingsRepository(db);
    backup = BackupRepository(db);
  });
  tearDown(() => db.close());

  test('export then import reproduces calendars, events and settings', () async {
    await repo.ensureSeeded(withSamples: true);
    await repo.saveCalendar(title: 'Fitness', colorId: 2);
    await settings.setThemeMode(ThemePref.dark);
    await settings.setWeekStart(DateTime.sunday);

    final before = await db.watchAllEvents().first;
    final json = await backup.exportJson();

    // wipe everything, then restore
    await db.clearAllEvents();
    await db.clearAllCalendars();
    expect(await db.watchAllEvents().first, isEmpty);
    await settings.setThemeMode(ThemePref.light); // scribble over settings

    await backup.importJson(json);

    final after = await db.watchAllEvents().first;
    expect(after.length, before.length);
    final cals = await repo.watchCalendars().first;
    expect(cals.any((c) => c.title == 'Fitness'), true);
    final s = await settings.watch().first;
    expect(s.themeMode, ThemePref.dark);
    expect(s.weekStart, DateTime.sunday);

    // a recurring seeded event keeps its rule
    final standup = after.firstWhere((e) => e.title == 'Standup');
    expect(recurrenceOf(standup).freq, Freq.daily);
  });

  test('import replaces existing data', () async {
    await repo.ensureSeeded();
    final json = await backup.exportJson();
    // add an extra calendar that should be gone after a restore
    await repo.saveCalendar(title: 'Temporary', colorId: 1);
    expect((await repo.watchCalendars().first).any((c) => c.title == 'Temporary'), true);

    await backup.importJson(json);
    expect((await repo.watchCalendars().first).any((c) => c.title == 'Temporary'), false);
  });

  test('rejects non-Cally / malformed / future-version documents', () async {
    await expectLater(backup.importJson('not json'), throwsA(isA<BackupFormatException>()));
    await expectLater(backup.importJson('{"app":"other","version":1,"calendars":[],"events":[]}'),
        throwsA(isA<BackupFormatException>()));
    await expectLater(
        backup.importJson('{"app":"cally","version":999,"calendars":[],"events":[]}'),
        throwsA(isA<BackupFormatException>()));
  });
}
