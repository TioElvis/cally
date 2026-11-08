import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

/// App-local calendars (M1). In M8 these mirror device calendars.
@DataClassName('CalendarRow')
class Calendars extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  IntColumn get colorId => integer()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  BoolColumn get isVisible => boolean().withDefault(const Constant(true))();
  IntColumn get displayOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Single-row app settings (M2).
@DataClassName('SettingsRow')
class AppSettingsTable extends Table {
  TextColumn get id => text().withDefault(const Constant('app'))();
  IntColumn get themeMode => integer().withDefault(const Constant(0))(); // 0 system,1 light,2 dark
  IntColumn get weekStart => integer().withDefault(const Constant(DateTime.monday))();
  BoolColumn get use24h => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Events, stored locally. Recurrence is kept flat (see core/time/recurrence).
@DataClassName('EventRow')
class Events extends Table {
  TextColumn get id => text()();
  TextColumn get calendarId => text().references(Calendars, #id)();
  TextColumn get title => text()();
  BoolColumn get allDay => boolean().withDefault(const Constant(false))();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime()();
  IntColumn get colorId => integer().nullable()(); // overrides calendar colour
  TextColumn get location => text().nullable()();
  TextColumn get url => text().nullable()();
  TextColumn get notes => text().nullable()();

  // recurrence
  IntColumn get recFreq => integer().withDefault(const Constant(0))(); // Freq.index
  IntColumn get recInterval => integer().withDefault(const Constant(1))();
  IntColumn get recEndKind => integer().withDefault(const Constant(0))(); // RecEndKind.index
  DateTimeColumn get recUntil => dateTime().nullable()();
  IntColumn get recCount => integer().nullable()();

  // single relative alert, minutes before start (null = no alert)
  IntColumn get alertMinutes => integer().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Calendars, Events, AppSettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
      : super(executor ?? driftDatabase(name: 'cally'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(calendars, calendars.isVisible);
            await m.createTable(appSettingsTable);
          }
        },
      );

  Stream<List<EventRow>> watchAllEvents() => select(events).watch();

  Stream<List<CalendarRow>> watchCalendars() =>
      (select(calendars)..orderBy([(c) => OrderingTerm(expression: c.displayOrder)]))
          .watch();

  Future<List<CalendarRow>> allCalendars() =>
      (select(calendars)..orderBy([(c) => OrderingTerm(expression: c.displayOrder)]))
          .get();

  Future<void> upsertEvent(EventsCompanion e) =>
      into(events).insertOnConflictUpdate(e);

  Future<void> deleteEvent(String id) =>
      (delete(events)..where((e) => e.id.equals(id))).go();

  Future<void> deleteEventsForCalendar(String calendarId) =>
      (delete(events)..where((e) => e.calendarId.equals(calendarId))).go();

  Future<void> upsertCalendar(CalendarsCompanion c) =>
      into(calendars).insertOnConflictUpdate(c);

  Future<void> deleteCalendar(String id) =>
      (delete(calendars)..where((c) => c.id.equals(id))).go();

  Future<void> updateCalendar(String id, CalendarsCompanion c) =>
      (update(calendars)..where((t) => t.id.equals(id))).write(c);

  Future<void> clearDefaultCalendars() =>
      (update(calendars)..where((c) => c.isDefault.equals(true)))
          .write(const CalendarsCompanion(isDefault: Value(false)));

  Future<int> calendarCount() async => (await select(calendars).get()).length;

  // --- settings ---
  Stream<SettingsRow?> watchSettings() =>
      (select(appSettingsTable)..where((t) => t.id.equals('app'))).watchSingleOrNull();

  Future<SettingsRow?> getSettings() =>
      (select(appSettingsTable)..where((t) => t.id.equals('app'))).getSingleOrNull();

  Future<void> upsertSettings(AppSettingsTableCompanion c) =>
      into(appSettingsTable).insertOnConflictUpdate(c);
}
