import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pt'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Cally'**
  String get appName;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @newEvent.
  ///
  /// In en, this message translates to:
  /// **'New event'**
  String get newEvent;

  /// No description provided for @noEvents.
  ///
  /// In en, this message translates to:
  /// **'No events'**
  String get noEvents;

  /// No description provided for @allDay.
  ///
  /// In en, this message translates to:
  /// **'All-day'**
  String get allDay;

  /// No description provided for @eventName.
  ///
  /// In en, this message translates to:
  /// **'Event name'**
  String get eventName;

  /// No description provided for @starts.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get starts;

  /// No description provided for @ends.
  ///
  /// In en, this message translates to:
  /// **'Ends'**
  String get ends;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get alert;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @deleteEvent.
  ///
  /// In en, this message translates to:
  /// **'Delete event'**
  String get deleteEvent;

  /// No description provided for @deleteEventQ.
  ///
  /// In en, this message translates to:
  /// **'Delete event?'**
  String get deleteEventQ;

  /// No description provided for @deleteSeriesNote.
  ///
  /// In en, this message translates to:
  /// **'This deletes the whole repeating series.'**
  String get deleteSeriesNote;

  /// No description provided for @repeatNever.
  ///
  /// In en, this message translates to:
  /// **'Doesn\'t repeat'**
  String get repeatNever;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get repeatMonthly;

  /// No description provided for @repeatYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get repeatYearly;

  /// No description provided for @alertNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get alertNone;

  /// No description provided for @atTimeOfEvent.
  ///
  /// In en, this message translates to:
  /// **'At time of event'**
  String get atTimeOfEvent;

  /// No description provided for @minutesBefore.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 minute before} other{{count} minutes before}}'**
  String minutesBefore(int count);

  /// No description provided for @hoursBefore.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 hour before} other{{count} hours before}}'**
  String hoursBefore(int count);

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @firstDayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'First day of week'**
  String get firstDayOfWeek;

  /// No description provided for @use24h.
  ///
  /// In en, this message translates to:
  /// **'24-hour time'**
  String get use24h;

  /// No description provided for @weekNumbers.
  ///
  /// In en, this message translates to:
  /// **'Week numbers'**
  String get weekNumbers;

  /// No description provided for @accentColor.
  ///
  /// In en, this message translates to:
  /// **'Accent color'**
  String get accentColor;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get enableNotifications;

  /// No description provided for @defaultAlert.
  ///
  /// In en, this message translates to:
  /// **'Default alert'**
  String get defaultAlert;

  /// No description provided for @defaultAlertAllDay.
  ///
  /// In en, this message translates to:
  /// **'Default alert (all-day)'**
  String get defaultAlertAllDay;

  /// No description provided for @morningDigest.
  ///
  /// In en, this message translates to:
  /// **'Morning digest'**
  String get morningDigest;

  /// No description provided for @eveningDigest.
  ///
  /// In en, this message translates to:
  /// **'Evening digest (tomorrow)'**
  String get eveningDigest;

  /// No description provided for @appIconBadge.
  ///
  /// In en, this message translates to:
  /// **'App icon badge'**
  String get appIconBadge;

  /// No description provided for @badgeNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get badgeNone;

  /// No description provided for @badgeDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get badgeDate;

  /// No description provided for @badgeCount.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get badgeCount;

  /// No description provided for @notificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Notifications enabled'**
  String get notificationsEnabled;

  /// No description provided for @notificationsOff.
  ///
  /// In en, this message translates to:
  /// **'Notifications off'**
  String get notificationsOff;

  /// No description provided for @notificationsOnMsg.
  ///
  /// In en, this message translates to:
  /// **'Cally can now remind you about events.'**
  String get notificationsOnMsg;

  /// No description provided for @notificationsOffMsg.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications in system settings to get alerts.'**
  String get notificationsOffMsg;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @calendars.
  ///
  /// In en, this message translates to:
  /// **'Calendars'**
  String get calendars;

  /// No description provided for @manageCalendars.
  ///
  /// In en, this message translates to:
  /// **'Manage calendars'**
  String get manageCalendars;

  /// No description provided for @newCalendar.
  ///
  /// In en, this message translates to:
  /// **'New calendar'**
  String get newCalendar;

  /// No description provided for @editCalendar.
  ///
  /// In en, this message translates to:
  /// **'Edit calendar'**
  String get editCalendar;

  /// No description provided for @calendarName.
  ///
  /// In en, this message translates to:
  /// **'Calendar name'**
  String get calendarName;

  /// No description provided for @renameRecolour.
  ///
  /// In en, this message translates to:
  /// **'Rename / recolour'**
  String get renameRecolour;

  /// No description provided for @makeDefault.
  ///
  /// In en, this message translates to:
  /// **'Make default'**
  String get makeDefault;

  /// No description provided for @moveUp.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get moveUp;

  /// No description provided for @moveDown.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get moveDown;

  /// No description provided for @defaultLabel.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultLabel;

  /// No description provided for @deleteCalendarQ.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"?'**
  String deleteCalendarQ(String title);

  /// No description provided for @calendarEventsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Its events are deleted too.'**
  String get calendarEventsDeleted;

  /// No description provided for @calendarsHint.
  ///
  /// In en, this message translates to:
  /// **'Tap a calendar to rename, recolour, reorder, set default or delete. The switch hides it from the grid.'**
  String get calendarsHint;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup & restore'**
  String get backupRestore;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @restoreTitle.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restoreTitle;

  /// No description provided for @exportToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Export to clipboard'**
  String get exportToClipboard;

  /// No description provided for @backupCopied.
  ///
  /// In en, this message translates to:
  /// **'Backup copied'**
  String get backupCopied;

  /// No description provided for @backupCopiedMsg.
  ///
  /// In en, this message translates to:
  /// **'Your data ({count} chars) is on the clipboard. Paste it somewhere safe, or into Restore on another device.'**
  String backupCopiedMsg(int count);

  /// No description provided for @backupFooter.
  ///
  /// In en, this message translates to:
  /// **'Copies all your calendars, events and settings as JSON to the clipboard. Keep it safe or paste it into Restore on another device.'**
  String get backupFooter;

  /// No description provided for @restoreFooter.
  ///
  /// In en, this message translates to:
  /// **'Paste a Cally backup and restore it. This replaces everything currently in the app.'**
  String get restoreFooter;

  /// No description provided for @pasteBackupHere.
  ///
  /// In en, this message translates to:
  /// **'Paste backup JSON here'**
  String get pasteBackupHere;

  /// No description provided for @restoreFromPasted.
  ///
  /// In en, this message translates to:
  /// **'Restore from pasted backup'**
  String get restoreFromPasted;

  /// No description provided for @restoreBackupQ.
  ///
  /// In en, this message translates to:
  /// **'Restore backup?'**
  String get restoreBackupQ;

  /// No description provided for @restoreReplaceWarning.
  ///
  /// In en, this message translates to:
  /// **'This replaces all current calendars and events.'**
  String get restoreReplaceWarning;

  /// No description provided for @restored.
  ///
  /// In en, this message translates to:
  /// **'Restored'**
  String get restored;

  /// No description provided for @restoredMsg.
  ///
  /// In en, this message translates to:
  /// **'Your data was restored from the backup.'**
  String get restoredMsg;

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore failed'**
  String get restoreFailed;

  /// No description provided for @restoreEvents.
  ///
  /// In en, this message translates to:
  /// **'Restore events'**
  String get restoreEvents;

  /// No description provided for @nothingToRestore.
  ///
  /// In en, this message translates to:
  /// **'Nothing to restore'**
  String get nothingToRestore;

  /// No description provided for @restoreAll.
  ///
  /// In en, this message translates to:
  /// **'Restore all'**
  String get restoreAll;

  /// No description provided for @deleteAllPermanently.
  ///
  /// In en, this message translates to:
  /// **'Delete all permanently'**
  String get deleteAllPermanently;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @localFree.
  ///
  /// In en, this message translates to:
  /// **'Local · free'**
  String get localFree;

  /// No description provided for @shareAsText.
  ///
  /// In en, this message translates to:
  /// **'Share as text'**
  String get shareAsText;

  /// No description provided for @shareAsIcs.
  ///
  /// In en, this message translates to:
  /// **'Share as calendar file (.ics)'**
  String get shareAsIcs;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Event name, location and notes'**
  String get searchPlaceholder;

  /// No description provided for @searchAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get searchAll;

  /// No description provided for @noMatches.
  ///
  /// In en, this message translates to:
  /// **'No matches'**
  String get noMatches;

  /// No description provided for @goToToday.
  ///
  /// In en, this message translates to:
  /// **'Go to today'**
  String get goToToday;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @tomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// No description provided for @eventsToday.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 event today} other{{count} events today}}'**
  String eventsToday(int count);

  /// No description provided for @eventsTomorrow.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 event tomorrow} other{{count} events tomorrow}}'**
  String eventsTomorrow(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
