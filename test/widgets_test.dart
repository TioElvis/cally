import 'dart:convert';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/features/widgets/deep_link.dart';
import 'package:cally/features/widgets/widget_payload.dart';

void main() {
  group('deep links', () {
    test('today / unknown / null -> OpenToday', () {
      expect(parseDeepLink(Uri.parse('cally://today')), isA<OpenToday>());
      expect(parseDeepLink(Uri.parse('cally://wat')), isA<OpenToday>());
      expect(parseDeepLink(null), isA<OpenToday>());
      expect(parseDeepLink(Uri.parse('https://example.com')), isA<OpenToday>());
    });
    test('day/<date> -> OpenDay', () {
      final a = parseDeepLink(Uri.parse('cally://day/2026-11-20'));
      expect(a, isA<OpenDay>());
      expect((a as OpenDay).day, DateTime(2026, 11, 20));
    });
    test('new and new/<date> -> NewEvent', () {
      expect((parseDeepLink(Uri.parse('cally://new')) as NewEvent).day, isNull);
      final b = parseDeepLink(Uri.parse('cally://new/2026-12-01'));
      expect((b as NewEvent).day, DateTime(2026, 12, 1));
    });
  });

  group('widget payload', () {
    late AppDatabase db;
    late EventRepository repo;
    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      repo = EventRepository(db);
    });
    tearDown(() => db.close());

    test('builds title, a 42-cell grid with today, upcoming and today count', () async {
      await repo.ensureSeeded(withSamples: true);
      final rows = await db.watchAllEvents().first;
      final cals = await repo.watchCalendars().first;
      final now = DateTime.now();
      final payload = buildWidgetPayload(
        events: rows,
        calColor: {for (final c in cals) c.id: c.colorId},
        weekStart: DateTime.monday,
        now: now,
      );
      expect(payload['title'], isNotEmpty);
      final grid = jsonDecode(payload['grid']!) as List;
      expect(grid.length, 42);
      expect(grid.where((c) => c['today'] == true).length, 1);
      // seeded sample has events today -> some dots and a non-zero count
      expect(int.parse(payload['todayCount']!), greaterThan(0));
      final upcoming = jsonDecode(payload['upcoming']!) as List;
      expect(upcoming, isNotEmpty);
      // upcoming is sorted ascending by start
      final starts = upcoming.map((e) => e['s'] as int).toList();
      final sorted = [...starts]..sort();
      expect(starts, sorted);
    });
  });
}
