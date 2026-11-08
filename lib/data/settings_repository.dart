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
}
