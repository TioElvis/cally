import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/event_repository.dart';
import 'package:cally/features/integrations/device_calendar_service.dart';

void main() {
  test('newCalendar returns a usable id and appends in order', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final repo = EventRepository(db);
    final a = await repo.newCalendar('Imported: Work', 7);
    final b = await repo.newCalendar('Imported: Home', 2);
    expect(a, isNotEmpty);
    expect(a == b, false);
    final cals = await repo.watchCalendars().first;
    expect(cals.map((c) => c.id), containsAll([a, b]));
    expect(cals.firstWhere((c) => c.id == b).displayOrder,
        greaterThan(cals.firstWhere((c) => c.id == a).displayOrder));
    await db.close();
  });

  test('device calendar service is the fake (unavailable) on this build', () async {
    final svc = createDeviceCalendarService();
    expect(svc.available, false);
    expect(await svc.ensurePermission(), false);
    expect(await svc.calendars(), isEmpty);
  });
}
