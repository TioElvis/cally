import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/data/models.dart';

void main() {
  late AppDatabase db;
  late EventRepository repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = EventRepository(db);
  });
  tearDown(() => db.close());

  test('ensureSeeded creates calendars and sample events, idempotently', () async {
    await repo.ensureSeeded(withSamples: true);
    await repo.ensureSeeded(withSamples: true); // second call is a no-op
    final cals = await db.allCalendars();
    expect(cals.length, 2);
    expect(cals.any((c) => c.isDefault), true);
    final rows = await db.watchAllEvents().first;
    expect(rows.length, 6);
  });

  test('save then delete is reflected in the store', () async {
    await repo.ensureSeeded();
    final before = (await db.watchAllEvents().first).length;
    final draft = EventDraft.newAt(DateTime(2026, 11, 20), 'personal')..title = 'Coffee';
    await repo.save(draft);
    var rows = await db.watchAllEvents().first;
    expect(rows.length, before + 1);
    final created = rows.firstWhere((r) => r.title == 'Coffee');
    await repo.delete(created.id);
    rows = await db.watchAllEvents().first;
    expect(rows.length, before);
  });

  test('a daily series expands across the whole week in the grid', () async {
    await repo.ensureSeeded(withSamples: true);
    final rows = await db.watchAllEvents().first;
    final color = {for (final c in await repo.watchCalendars().first) c.id: c.colorId};
    final standup = rows.firstWhere((r) => r.title == 'Standup');
    final from = DateTime(standup.start.year, standup.start.month, standup.start.day);
    final to = from.add(const Duration(days: 7));
    final occ = expandAll(rows, color, from, to).where((o) => o.title == 'Standup');
    expect(occ.length, 7); // daily -> once per day in the window
  });
}
