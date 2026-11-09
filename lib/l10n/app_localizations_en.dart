// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Cally';

  @override
  String get cancel => 'Cancel';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get restore => 'Restore';

  @override
  String get today => 'Today';

  @override
  String get newEvent => 'New event';

  @override
  String get noEvents => 'No events';

  @override
  String get allDay => 'All-day';

  @override
  String get eventName => 'Event name';

  @override
  String get starts => 'Starts';

  @override
  String get ends => 'Ends';

  @override
  String get calendar => 'Calendar';

  @override
  String get color => 'Color';

  @override
  String get repeat => 'Repeat';

  @override
  String get alert => 'Alert';

  @override
  String get notes => 'Notes';

  @override
  String get deleteEvent => 'Delete event';

  @override
  String get deleteEventQ => 'Delete event?';

  @override
  String get deleteSeriesNote => 'This deletes the whole repeating series.';

  @override
  String get repeatNever => 'Doesn\'t repeat';

  @override
  String get repeatDaily => 'Daily';

  @override
  String get repeatWeekly => 'Weekly';

  @override
  String get repeatMonthly => 'Monthly';

  @override
  String get repeatYearly => 'Yearly';

  @override
  String get alertNone => 'None';

  @override
  String get atTimeOfEvent => 'At time of event';

  @override
  String minutesBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes before',
      one: '1 minute before',
    );
    return '$_temp0';
  }

  @override
  String hoursBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours before',
      one: '1 hour before',
    );
    return '$_temp0';
  }

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get firstDayOfWeek => 'First day of week';

  @override
  String get use24h => '24-hour time';

  @override
  String get weekNumbers => 'Week numbers';

  @override
  String get accentColor => 'Accent color';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Enable notifications';

  @override
  String get defaultAlert => 'Default alert';

  @override
  String get defaultAlertAllDay => 'Default alert (all-day)';

  @override
  String get morningDigest => 'Morning digest';

  @override
  String get eveningDigest => 'Evening digest (tomorrow)';

  @override
  String get appIconBadge => 'App icon badge';

  @override
  String get badgeNone => 'None';

  @override
  String get badgeDate => 'Date';

  @override
  String get badgeCount => 'Count';

  @override
  String get notificationsEnabled => 'Notifications enabled';

  @override
  String get notificationsOff => 'Notifications off';

  @override
  String get notificationsOnMsg => 'Cally can now remind you about events.';

  @override
  String get notificationsOffMsg =>
      'Allow notifications in system settings to get alerts.';

  @override
  String get settings => 'Settings';

  @override
  String get calendars => 'Calendars';

  @override
  String get manageCalendars => 'Manage calendars';

  @override
  String get newCalendar => 'New calendar';

  @override
  String get editCalendar => 'Edit calendar';

  @override
  String get calendarName => 'Calendar name';

  @override
  String get renameRecolour => 'Rename / recolour';

  @override
  String get makeDefault => 'Make default';

  @override
  String get moveUp => 'Move up';

  @override
  String get moveDown => 'Move down';

  @override
  String get defaultLabel => 'Default';

  @override
  String deleteCalendarQ(String title) {
    return 'Delete \"$title\"?';
  }

  @override
  String get calendarEventsDeleted => 'Its events are deleted too.';

  @override
  String get calendarsHint =>
      'Tap a calendar to rename, recolour, reorder, set default or delete. The switch hides it from the grid.';

  @override
  String get data => 'Data';

  @override
  String get backupRestore => 'Backup & restore';

  @override
  String get backup => 'Backup';

  @override
  String get restoreTitle => 'Restore';

  @override
  String get exportToClipboard => 'Export to clipboard';

  @override
  String get backupCopied => 'Backup copied';

  @override
  String backupCopiedMsg(int count) {
    return 'Your data ($count chars) is on the clipboard. Paste it somewhere safe, or into Restore on another device.';
  }

  @override
  String get backupFooter =>
      'Copies all your calendars, events and settings as JSON to the clipboard. Keep it safe or paste it into Restore on another device.';

  @override
  String get restoreFooter =>
      'Paste a Cally backup and restore it. This replaces everything currently in the app.';

  @override
  String get pasteBackupHere => 'Paste backup JSON here';

  @override
  String get restoreFromPasted => 'Restore from pasted backup';

  @override
  String get restoreBackupQ => 'Restore backup?';

  @override
  String get restoreReplaceWarning =>
      'This replaces all current calendars and events.';

  @override
  String get restored => 'Restored';

  @override
  String get restoredMsg => 'Your data was restored from the backup.';

  @override
  String get restoreFailed => 'Restore failed';

  @override
  String get restoreEvents => 'Restore events';

  @override
  String get nothingToRestore => 'Nothing to restore';

  @override
  String get restoreAll => 'Restore all';

  @override
  String get deleteAllPermanently => 'Delete all permanently';

  @override
  String get about => 'About';

  @override
  String get localFree => 'Local · free';

  @override
  String get shareAsText => 'Share as text';

  @override
  String get shareAsIcs => 'Share as calendar file (.ics)';

  @override
  String get search => 'Search';

  @override
  String get searchPlaceholder => 'Event name, location and notes';

  @override
  String get searchAll => 'All';

  @override
  String get noMatches => 'No matches';

  @override
  String get goToToday => 'Go to today';

  @override
  String get done => 'Done';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count events today',
      one: '1 event today',
    );
    return '$_temp0';
  }

  @override
  String eventsTomorrow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count events tomorrow',
      one: '1 event tomorrow',
    );
    return '$_temp0';
  }
}
