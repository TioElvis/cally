import 'dart:convert';

import 'package:drift/drift.dart';

import 'db/database.dart';

/// Exception thrown when an import document is not a valid Cally backup.
class BackupFormatException implements Exception {
  final String message;
  BackupFormatException(this.message);
  @override
  String toString() => 'BackupFormatException: $message';
}

/// Backup & restore of the whole local store (calendars, events, settings) as a
/// portable JSON document. This is the data layer any cross-device sync reuses;
/// the cloud transport (iCloud/CloudKit on iOS, a chosen Android mechanism) is a
/// later milestone — the document shape stays the same.
class BackupRepository {
  static const appTag = 'cally';
  static const formatVersion = 1;

  final AppDatabase db;
  BackupRepository(this.db);

  Future<Map<String, dynamic>> exportMap() async {
    final cals = await db.allCalendars();
    final events = await db.watchAllEvents().first;
    final settings = await db.getSettings();

    return {
      'app': appTag,
      'version': formatVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'calendars': cals
          .map((c) => {
                'id': c.id,
                'title': c.title,
                'colorId': c.colorId,
                'isDefault': c.isDefault,
                'isVisible': c.isVisible,
                'displayOrder': c.displayOrder,
              })
          .toList(),
      'events': events.map(_eventToMap).toList(),
      'settings': settings == null ? null : _settingsToMap(settings),
    };
  }

  Future<String> exportJson() async =>
      const JsonEncoder.withIndent('  ').convert(await exportMap());

  /// Replace the entire store with the backup's contents.
  Future<void> importJson(String json) async {
    final doc = _parse(json);
    final cals = (doc['calendars'] as List).cast<Map<String, dynamic>>();
    final events = (doc['events'] as List).cast<Map<String, dynamic>>();
    final settings = doc['settings'] as Map<String, dynamic>?;

    await db.transaction(() async {
      await db.clearAllEvents();
      await db.clearAllCalendars();
      for (final c in cals) {
        await db.upsertCalendar(CalendarsCompanion.insert(
          id: c['id'] as String,
          title: c['title'] as String,
          colorId: c['colorId'] as int,
          isDefault: Value(c['isDefault'] as bool? ?? false),
          isVisible: Value(c['isVisible'] as bool? ?? true),
          displayOrder: Value(c['displayOrder'] as int? ?? 0),
        ));
      }
      for (final e in events) {
        await db.upsertEvent(_mapToEvent(e));
      }
      if (settings != null) {
        await db.upsertSettings(_mapToSettings(settings));
      }
    });
  }

  Map<String, dynamic> _parse(String json) {
    late final dynamic decoded;
    try {
      decoded = jsonDecode(json);
    } catch (_) {
      throw BackupFormatException('Not valid JSON.');
    }
    if (decoded is! Map<String, dynamic>) {
      throw BackupFormatException('Not a Cally backup.');
    }
    if (decoded['app'] != appTag) {
      throw BackupFormatException('This is not a Cally backup.');
    }
    final v = decoded['version'];
    if (v is! int || v > formatVersion) {
      throw BackupFormatException('Unsupported backup version: $v.');
    }
    if (decoded['calendars'] is! List || decoded['events'] is! List) {
      throw BackupFormatException('Backup is missing calendars or events.');
    }
    return decoded;
  }

  // --- field mapping ---

  Map<String, dynamic> _eventToMap(EventRow e) => {
        'id': e.id,
        'calendarId': e.calendarId,
        'title': e.title,
        'allDay': e.allDay,
        'start': e.start.toIso8601String(),
        'end': e.end.toIso8601String(),
        'colorId': e.colorId,
        'location': e.location,
        'url': e.url,
        'notes': e.notes,
        'recFreq': e.recFreq,
        'recInterval': e.recInterval,
        'recEndKind': e.recEndKind,
        'recUntil': e.recUntil?.toIso8601String(),
        'recCount': e.recCount,
        'alertMinutes': e.alertMinutes,
      };

  EventsCompanion _mapToEvent(Map<String, dynamic> e) => EventsCompanion.insert(
        id: e['id'] as String,
        calendarId: e['calendarId'] as String,
        title: e['title'] as String,
        start: DateTime.parse(e['start'] as String),
        end: DateTime.parse(e['end'] as String),
        allDay: Value(e['allDay'] as bool? ?? false),
        colorId: Value(e['colorId'] as int?),
        location: Value(e['location'] as String?),
        url: Value(e['url'] as String?),
        notes: Value(e['notes'] as String?),
        recFreq: Value(e['recFreq'] as int? ?? 0),
        recInterval: Value(e['recInterval'] as int? ?? 1),
        recEndKind: Value(e['recEndKind'] as int? ?? 0),
        recUntil: Value(_date(e['recUntil'])),
        recCount: Value(e['recCount'] as int?),
        alertMinutes: Value(e['alertMinutes'] as int?),
      );

  Map<String, dynamic> _settingsToMap(SettingsRow s) => {
        'themeMode': s.themeMode,
        'weekStart': s.weekStart,
        'use24h': s.use24h,
        'defaultAlertTimed': s.defaultAlertTimed,
        'defaultAlertAllDay': s.defaultAlertAllDay,
        'digestMorningOn': s.digestMorningOn,
        'digestMorningMin': s.digestMorningMin,
        'digestEveningOn': s.digestEveningOn,
        'digestEveningMin': s.digestEveningMin,
        'badgeType': s.badgeType,
      };

  AppSettingsTableCompanion _mapToSettings(Map<String, dynamic> s) =>
      AppSettingsTableCompanion(
        id: const Value('app'),
        themeMode: Value(s['themeMode'] as int? ?? 0),
        weekStart: Value(s['weekStart'] as int? ?? DateTime.monday),
        use24h: Value(s['use24h'] as bool? ?? true),
        defaultAlertTimed: Value(s['defaultAlertTimed'] as int?),
        defaultAlertAllDay: Value(s['defaultAlertAllDay'] as int?),
        digestMorningOn: Value(s['digestMorningOn'] as bool? ?? false),
        digestMorningMin: Value(s['digestMorningMin'] as int? ?? 8 * 60),
        digestEveningOn: Value(s['digestEveningOn'] as bool? ?? false),
        digestEveningMin: Value(s['digestEveningMin'] as int? ?? 20 * 60),
        badgeType: Value(s['badgeType'] as int? ?? 0),
      );

  DateTime? _date(dynamic s) => s == null ? null : DateTime.parse(s as String);
}
