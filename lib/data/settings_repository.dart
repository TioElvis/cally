import 'package:drift/drift.dart';

import 'db/database.dart';
import 'models.dart';

/// App settings, backed by the single-row settings table.
class SettingsRepository {
  final AppDatabase db;
  SettingsRepository(this.db);

  Stream<AppSettings> watch() => db.watchSettings().map(AppSettings.from);

  Future<void> setThemeMode(ThemePref t) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), themeMode: Value(t.index)));

  Future<void> setWeekStart(int weekday) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), weekStart: Value(weekday)));

  Future<void> setUse24h(bool v) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), use24h: Value(v)));

  // M3
  Future<void> setDefaultAlertTimed(int? minutes) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), defaultAlertTimed: Value(minutes)));

  Future<void> setDefaultAlertAllDay(int? minutes) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), defaultAlertAllDay: Value(minutes)));

  Future<void> setMorningDigest(bool on, int minutes) => db.upsertSettings(AppSettingsTableCompanion(
      id: const Value('app'),
      digestMorningOn: Value(on),
      digestMorningMin: Value(minutes)));

  Future<void> setEveningDigest(bool on, int minutes) => db.upsertSettings(AppSettingsTableCompanion(
      id: const Value('app'),
      digestEveningOn: Value(on),
      digestEveningMin: Value(minutes)));

  Future<void> setBadgeType(BadgeType t) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), badgeType: Value(t.index)));

  // M7
  Future<void> setPro(bool v) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), isPro: Value(v)));

  Future<void> setShowWeekNumbers(bool v) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), showWeekNumbers: Value(v)));

  Future<void> setAccent(int id) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), accentId: Value(id)));

  /// Manual language override; pass null to follow the device language.
  Future<void> setLanguage(String? code) => db.upsertSettings(
      AppSettingsTableCompanion(id: const Value('app'), languageCode: Value(code)));
}
