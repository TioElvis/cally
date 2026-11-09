import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/iso_week.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/settings_repository.dart';

void main() {
  test('ISO week number at year boundaries', () {
    expect(isoWeekNumber(DateTime(2024, 12, 30)), 1);  // Mon -> week 1 of 2025
    expect(isoWeekNumber(DateTime(2023, 1, 1)), 52);   // Sun -> week 52 of 2022
    expect(isoWeekNumber(DateTime(2026, 1, 1)), 1);
    expect(isoWeekNumber(DateTime(2026, 11, 10)), 46);
  });

  test('week numbers are free: enabling the setting turns them on', () async {
    final db = AppDatabase(NativeDatabase.memory());
    final settings = SettingsRepository(db);
    expect((await settings.watch().first).weekNumbersEnabled, false);
    await settings.setShowWeekNumbers(true);
    expect((await settings.watch().first).weekNumbersEnabled, true); // no Pro gate
    await db.close();
  });
}
