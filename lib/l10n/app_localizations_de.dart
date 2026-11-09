// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Cally';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Sichern';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get restore => 'Wiederherstellen';

  @override
  String get today => 'Heute';

  @override
  String get newEvent => 'Neuer Termin';

  @override
  String get noEvents => 'Keine Termine';

  @override
  String get allDay => 'Ganztägig';

  @override
  String get eventName => 'Terminname';

  @override
  String get starts => 'Beginn';

  @override
  String get ends => 'Ende';

  @override
  String get calendar => 'Kalender';

  @override
  String get color => 'Farbe';

  @override
  String get repeat => 'Wiederholen';

  @override
  String get alert => 'Hinweis';

  @override
  String get notes => 'Notizen';

  @override
  String get deleteEvent => 'Termin löschen';

  @override
  String get deleteEventQ => 'Termin löschen?';

  @override
  String get deleteSeriesNote => 'Dies löscht die gesamte Serie.';

  @override
  String get repeatNever => 'Wiederholt sich nicht';

  @override
  String get repeatDaily => 'Täglich';

  @override
  String get repeatWeekly => 'Wöchentlich';

  @override
  String get repeatMonthly => 'Monatlich';

  @override
  String get repeatYearly => 'Jährlich';

  @override
  String get alertNone => 'Keiner';

  @override
  String get atTimeOfEvent => 'Zur Terminzeit';

  @override
  String minutesBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Minuten vorher',
      one: '1 Minute vorher',
    );
    return '$_temp0';
  }

  @override
  String hoursBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Stunden vorher',
      one: '1 Stunde vorher',
    );
    return '$_temp0';
  }

  @override
  String get appearance => 'Darstellung';

  @override
  String get theme => 'Design';

  @override
  String get system => 'System';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get firstDayOfWeek => 'Erster Wochentag';

  @override
  String get use24h => '24-Stunden-Format';

  @override
  String get weekNumbers => 'Kalenderwochen';

  @override
  String get accentColor => 'Akzentfarbe';

  @override
  String get language => 'Sprache';

  @override
  String get languageSystem => 'Systemstandard';

  @override
  String get notifications => 'Mitteilungen';

  @override
  String get enableNotifications => 'Mitteilungen aktivieren';

  @override
  String get defaultAlert => 'Standardhinweis';

  @override
  String get defaultAlertAllDay => 'Standardhinweis (ganztägig)';

  @override
  String get morningDigest => 'Morgenübersicht';

  @override
  String get eveningDigest => 'Abendübersicht (morgen)';

  @override
  String get appIconBadge => 'App-Symbol-Kennzeichen';

  @override
  String get badgeNone => 'Keines';

  @override
  String get badgeDate => 'Datum';

  @override
  String get badgeCount => 'Anzahl';

  @override
  String get notificationsEnabled => 'Mitteilungen aktiviert';

  @override
  String get notificationsOff => 'Mitteilungen aus';

  @override
  String get notificationsOnMsg => 'Cally kann dich jetzt an Termine erinnern.';

  @override
  String get notificationsOffMsg =>
      'Erlaube Mitteilungen in den Systemeinstellungen, um Hinweise zu erhalten.';

  @override
  String get settings => 'Einstellungen';

  @override
  String get calendars => 'Kalender';

  @override
  String get manageCalendars => 'Kalender verwalten';

  @override
  String get newCalendar => 'Neuer Kalender';

  @override
  String get editCalendar => 'Kalender bearbeiten';

  @override
  String get calendarName => 'Kalendername';

  @override
  String get renameRecolour => 'Umbenennen / umfärben';

  @override
  String get makeDefault => 'Als Standard';

  @override
  String get moveUp => 'Nach oben';

  @override
  String get moveDown => 'Nach unten';

  @override
  String get defaultLabel => 'Standard';

  @override
  String deleteCalendarQ(String title) {
    return '„$title“ löschen?';
  }

  @override
  String get calendarEventsDeleted =>
      'Seine Termine werden ebenfalls gelöscht.';

  @override
  String get calendarsHint =>
      'Tippe auf einen Kalender, um ihn umzubenennen, umzufärben, neu zu ordnen, als Standard zu setzen oder zu löschen. Der Schalter blendet ihn aus dem Raster aus.';

  @override
  String get data => 'Daten';

  @override
  String get backupRestore => 'Sicherung & Wiederherstellung';

  @override
  String get backup => 'Sicherung';

  @override
  String get restoreTitle => 'Wiederherstellen';

  @override
  String get exportToClipboard => 'In die Zwischenablage';

  @override
  String get backupCopied => 'Sicherung kopiert';

  @override
  String backupCopiedMsg(int count) {
    return 'Deine Daten ($count Zeichen) sind in der Zwischenablage. Füge sie sicher ein oder in Wiederherstellen auf einem anderen Gerät.';
  }

  @override
  String get backupFooter =>
      'Kopiert alle Kalender, Termine und Einstellungen als JSON in die Zwischenablage. Bewahre sie auf oder füge sie in Wiederherstellen auf einem anderen Gerät ein.';

  @override
  String get restoreFooter =>
      'Füge eine Cally-Sicherung ein und stelle sie wieder her. Dies ersetzt alles in der App.';

  @override
  String get pasteBackupHere => 'Sicherungs-JSON hier einfügen';

  @override
  String get restoreFromPasted => 'Aus eingefügter Sicherung wiederherstellen';

  @override
  String get restoreBackupQ => 'Sicherung wiederherstellen?';

  @override
  String get restoreReplaceWarning =>
      'Dies ersetzt alle aktuellen Kalender und Termine.';

  @override
  String get restored => 'Wiederhergestellt';

  @override
  String get restoredMsg =>
      'Deine Daten wurden aus der Sicherung wiederhergestellt.';

  @override
  String get restoreFailed => 'Wiederherstellung fehlgeschlagen';

  @override
  String get restoreEvents => 'Termine wiederherstellen';

  @override
  String get nothingToRestore => 'Nichts wiederherzustellen';

  @override
  String get restoreAll => 'Alle wiederherstellen';

  @override
  String get deleteAllPermanently => 'Alle endgültig löschen';

  @override
  String get about => 'Über';

  @override
  String get localFree => 'Lokal · kostenlos';

  @override
  String get shareAsText => 'Als Text teilen';

  @override
  String get shareAsIcs => 'Als Kalenderdatei (.ics) teilen';

  @override
  String get search => 'Suchen';

  @override
  String get searchPlaceholder => 'Terminname, Ort und Notizen';

  @override
  String get searchAll => 'Alle';

  @override
  String get noMatches => 'Keine Treffer';

  @override
  String get goToToday => 'Zu heute';

  @override
  String get done => 'Fertig';

  @override
  String get tomorrow => 'Morgen';

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Termine heute',
      one: '1 Termin heute',
    );
    return '$_temp0';
  }

  @override
  String eventsTomorrow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Termine morgen',
      one: '1 Termin morgen',
    );
    return '$_temp0';
  }
}
