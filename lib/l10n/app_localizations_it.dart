// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Cally';

  @override
  String get cancel => 'Annulla';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Salva';

  @override
  String get delete => 'Elimina';

  @override
  String get edit => 'Modifica';

  @override
  String get restore => 'Ripristina';

  @override
  String get today => 'Oggi';

  @override
  String get newEvent => 'Nuovo evento';

  @override
  String get noEvents => 'Nessun evento';

  @override
  String get allDay => 'Tutto il giorno';

  @override
  String get eventName => 'Nome evento';

  @override
  String get starts => 'Inizia';

  @override
  String get ends => 'Finisce';

  @override
  String get calendar => 'Calendario';

  @override
  String get color => 'Colore';

  @override
  String get repeat => 'Ripeti';

  @override
  String get alert => 'Avviso';

  @override
  String get notes => 'Note';

  @override
  String get deleteEvent => 'Elimina evento';

  @override
  String get deleteEventQ => 'Eliminare l’evento?';

  @override
  String get deleteSeriesNote => 'Elimina l’intera serie ricorrente.';

  @override
  String get repeatNever => 'Non si ripete';

  @override
  String get repeatDaily => 'Ogni giorno';

  @override
  String get repeatWeekly => 'Ogni settimana';

  @override
  String get repeatMonthly => 'Ogni mese';

  @override
  String get repeatYearly => 'Ogni anno';

  @override
  String get alertNone => 'Nessuno';

  @override
  String get atTimeOfEvent => 'All’ora dell’evento';

  @override
  String minutesBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minuti prima',
      one: '1 minuto prima',
    );
    return '$_temp0';
  }

  @override
  String hoursBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ore prima',
      one: '1 ora prima',
    );
    return '$_temp0';
  }

  @override
  String get appearance => 'Aspetto';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Chiaro';

  @override
  String get dark => 'Scuro';

  @override
  String get firstDayOfWeek => 'Primo giorno della settimana';

  @override
  String get use24h => 'Formato 24 ore';

  @override
  String get weekNumbers => 'Numeri di settimana';

  @override
  String get accentColor => 'Colore principale';

  @override
  String get notifications => 'Notifiche';

  @override
  String get enableNotifications => 'Attiva le notifiche';

  @override
  String get defaultAlert => 'Avviso predefinito';

  @override
  String get defaultAlertAllDay => 'Avviso predefinito (giornata intera)';

  @override
  String get morningDigest => 'Riepilogo del mattino';

  @override
  String get eveningDigest => 'Riepilogo della sera (domani)';

  @override
  String get appIconBadge => 'Badge sull’icona';

  @override
  String get badgeNone => 'Nessuno';

  @override
  String get badgeDate => 'Data';

  @override
  String get badgeCount => 'Conteggio';

  @override
  String get notificationsEnabled => 'Notifiche attive';

  @override
  String get notificationsOff => 'Notifiche disattivate';

  @override
  String get notificationsOnMsg => 'Cally può ora ricordarti gli eventi.';

  @override
  String get notificationsOffMsg =>
      'Consenti le notifiche nelle impostazioni di sistema per ricevere gli avvisi.';

  @override
  String get settings => 'Impostazioni';

  @override
  String get calendars => 'Calendari';

  @override
  String get manageCalendars => 'Gestisci calendari';

  @override
  String get newCalendar => 'Nuovo calendario';

  @override
  String get editCalendar => 'Modifica calendario';

  @override
  String get calendarName => 'Nome del calendario';

  @override
  String get renameRecolour => 'Rinomina / cambia colore';

  @override
  String get makeDefault => 'Imposta come predefinito';

  @override
  String get moveUp => 'Sposta su';

  @override
  String get moveDown => 'Sposta giù';

  @override
  String get defaultLabel => 'Predefinito';

  @override
  String deleteCalendarQ(String title) {
    return 'Eliminare “$title”?';
  }

  @override
  String get calendarEventsDeleted => 'Verranno eliminati anche i suoi eventi.';

  @override
  String get calendarsHint =>
      'Tocca un calendario per rinominarlo, cambiarne colore, riordinarlo, impostarlo predefinito o eliminarlo. L’interruttore lo nasconde dalla griglia.';

  @override
  String get data => 'Dati';

  @override
  String get backupRestore => 'Backup e ripristino';

  @override
  String get backup => 'Backup';

  @override
  String get restoreTitle => 'Ripristino';

  @override
  String get exportToClipboard => 'Esporta negli appunti';

  @override
  String get backupCopied => 'Backup copiato';

  @override
  String backupCopiedMsg(int count) {
    return 'I tuoi dati ($count caratteri) sono negli appunti. Incollali in un posto sicuro o in Ripristino su un altro dispositivo.';
  }

  @override
  String get backupFooter =>
      'Copia tutti i tuoi calendari, eventi e impostazioni come JSON negli appunti. Conservalo o incollalo in Ripristino su un altro dispositivo.';

  @override
  String get restoreFooter =>
      'Incolla un backup di Cally e ripristinalo. Questo sostituisce tutto ciò che c’è nell’app.';

  @override
  String get pasteBackupHere => 'Incolla qui il JSON del backup';

  @override
  String get restoreFromPasted => 'Ripristina dal backup incollato';

  @override
  String get restoreBackupQ => 'Ripristinare il backup?';

  @override
  String get restoreReplaceWarning =>
      'Questo sostituisce tutti i calendari e gli eventi attuali.';

  @override
  String get restored => 'Ripristinato';

  @override
  String get restoredMsg => 'I tuoi dati sono stati ripristinati dal backup.';

  @override
  String get restoreFailed => 'Ripristino non riuscito';

  @override
  String get restoreEvents => 'Ripristina eventi';

  @override
  String get nothingToRestore => 'Niente da ripristinare';

  @override
  String get restoreAll => 'Ripristina tutto';

  @override
  String get deleteAllPermanently => 'Elimina tutto definitivamente';

  @override
  String get about => 'Informazioni';

  @override
  String get localFree => 'Locale · gratis';

  @override
  String get shareAsText => 'Condividi come testo';

  @override
  String get shareAsIcs => 'Condividi come file calendario (.ics)';

  @override
  String get search => 'Cerca';

  @override
  String get searchPlaceholder => 'Nome evento, luogo e note';

  @override
  String get searchAll => 'Tutti';

  @override
  String get noMatches => 'Nessun risultato';

  @override
  String get goToToday => 'Vai a oggi';

  @override
  String get done => 'Fine';

  @override
  String get tomorrow => 'Domani';

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventi oggi',
      one: '1 evento oggi',
    );
    return '$_temp0';
  }

  @override
  String eventsTomorrow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventi domani',
      one: '1 evento domani',
    );
    return '$_temp0';
  }
}
