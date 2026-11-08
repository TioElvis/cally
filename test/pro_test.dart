import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/iso_week.dart';
import 'package:cally/data/db/database.dart';
import 'package:cally/data/models.dart';
import 'package:cally/data/settings_repository.dart';
import 'package:cally/features/pro/pro.dart';

void main() {
  group('isoWeekNumber', () {
    test('known ISO week boundaries', () {
      // 2024-12-30 (Mon) is ISO week 1 of 2025.
      expect(isoWeekNumber(DateTime(2024, 12, 30)), 1);
      // 2023-01-01 (Sun) belongs to ISO week 52 of 2022.
      expect(isoWeekNumber(DateTime(2023, 1, 1)), 52);
      // 2026-01-01 (Thu) is ISO week 1.
      expect(isoWeekNumber(DateTime(2026, 1, 1)), 1);
      // mid-year sanity: 2026-11-10 is week 46.
      expect(isoWeekNumber(DateTime(2026, 11, 10)), 46);
    });
  });

  group('entitlement + gating', () {
    late AppDatabase db;
    late SettingsRepository settings;
    setUp(() {
      db = AppDatabase(NativeDatabase.memory());
      settings = SettingsRepository(db);
    });
    tearDown(() => db.close());

    test('week numbers only count when enabled AND Pro', () async {
      final s0 = await settings.watch().first;
      expect(s0.isPro, false);
      expect(s0.weekNumbersEnabled, false);

      await settings.setShowWeekNumbers(true); // enabled but not Pro
      expect((await settings.watch().first).weekNumbersEnabled, false);

      await settings.setPro(true);
      final s1 = await settings.watch().first;
      expect(s1.isPro, true);
      expect(s1.weekNumbersEnabled, true);
    });

    test('fake purchase unlocks Pro; restore reports the current state', () async {
      final purchases = FakePurchaseService(settings, () => false);
      expect(await purchases.buyPro(), true);
      expect((await settings.watch().first).isPro, true);

      final pro = FakePurchaseService(settings, () => true);
      expect(await pro.restore(), true);
    });
  });
}
