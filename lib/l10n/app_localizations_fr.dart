// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Cally';

  @override
  String get cancel => 'Annuler';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Enregistrer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get restore => 'Restaurer';

  @override
  String get today => 'Aujourd’hui';

  @override
  String get newEvent => 'Nouvel événement';

  @override
  String get noEvents => 'Aucun événement';

  @override
  String get allDay => 'Journée entière';

  @override
  String get eventName => 'Nom de l’événement';

  @override
  String get starts => 'Début';

  @override
  String get ends => 'Fin';

  @override
  String get calendar => 'Calendrier';

  @override
  String get color => 'Couleur';

  @override
  String get repeat => 'Répéter';

  @override
  String get alert => 'Alerte';

  @override
  String get notes => 'Notes';

  @override
  String get deleteEvent => 'Supprimer l’événement';

  @override
  String get deleteEventQ => 'Supprimer l’événement ?';

  @override
  String get deleteSeriesNote => 'Cela supprime toute la série récurrente.';

  @override
  String get repeatNever => 'Ne se répète pas';

  @override
  String get repeatDaily => 'Chaque jour';

  @override
  String get repeatWeekly => 'Chaque semaine';

  @override
  String get repeatMonthly => 'Chaque mois';

  @override
  String get repeatYearly => 'Chaque année';

  @override
  String get alertNone => 'Aucune';

  @override
  String get atTimeOfEvent => 'À l’heure de l’événement';

  @override
  String minutesBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes avant',
      one: '1 minute avant',
    );
    return '$_temp0';
  }

  @override
  String hoursBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures avant',
      one: '1 heure avant',
    );
    return '$_temp0';
  }

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Thème';

  @override
  String get system => 'Système';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get firstDayOfWeek => 'Premier jour de la semaine';

  @override
  String get use24h => 'Format 24 heures';

  @override
  String get weekNumbers => 'Numéros de semaine';

  @override
  String get accentColor => 'Couleur d’accent';

  @override
  String get notifications => 'Notifications';

  @override
  String get enableNotifications => 'Activer les notifications';

  @override
  String get defaultAlert => 'Alerte par défaut';

  @override
  String get defaultAlertAllDay => 'Alerte par défaut (journée)';

  @override
  String get morningDigest => 'Résumé du matin';

  @override
  String get eveningDigest => 'Résumé du soir (demain)';

  @override
  String get appIconBadge => 'Pastille sur l’icône';

  @override
  String get badgeNone => 'Aucune';

  @override
  String get badgeDate => 'Date';

  @override
  String get badgeCount => 'Nombre';

  @override
  String get notificationsEnabled => 'Notifications activées';

  @override
  String get notificationsOff => 'Notifications désactivées';

  @override
  String get notificationsOnMsg =>
      'Cally peut maintenant vous rappeler vos événements.';

  @override
  String get notificationsOffMsg =>
      'Autorisez les notifications dans les réglages du système pour recevoir les alertes.';

  @override
  String get settings => 'Réglages';

  @override
  String get calendars => 'Calendriers';

  @override
  String get manageCalendars => 'Gérer les calendriers';

  @override
  String get newCalendar => 'Nouveau calendrier';

  @override
  String get editCalendar => 'Modifier le calendrier';

  @override
  String get calendarName => 'Nom du calendrier';

  @override
  String get renameRecolour => 'Renommer / recolorer';

  @override
  String get makeDefault => 'Définir par défaut';

  @override
  String get moveUp => 'Monter';

  @override
  String get moveDown => 'Descendre';

  @override
  String get defaultLabel => 'Par défaut';

  @override
  String deleteCalendarQ(String title) {
    return 'Supprimer « $title » ?';
  }

  @override
  String get calendarEventsDeleted => 'Ses événements sont aussi supprimés.';

  @override
  String get calendarsHint =>
      'Touchez un calendrier pour le renommer, le recolorer, le réordonner, le définir par défaut ou le supprimer. L’interrupteur le masque de la grille.';

  @override
  String get data => 'Données';

  @override
  String get backupRestore => 'Sauvegarde et restauration';

  @override
  String get backup => 'Sauvegarde';

  @override
  String get restoreTitle => 'Restauration';

  @override
  String get exportToClipboard => 'Exporter vers le presse-papiers';

  @override
  String get backupCopied => 'Sauvegarde copiée';

  @override
  String backupCopiedMsg(int count) {
    return 'Vos données ($count caractères) sont dans le presse-papiers. Collez-les en lieu sûr ou dans Restauration sur un autre appareil.';
  }

  @override
  String get backupFooter =>
      'Copie tous vos calendriers, événements et réglages en JSON dans le presse-papiers. Conservez-le ou collez-le dans Restauration sur un autre appareil.';

  @override
  String get restoreFooter =>
      'Collez une sauvegarde Cally et restaurez-la. Cela remplace tout ce qui se trouve dans l’app.';

  @override
  String get pasteBackupHere => 'Collez le JSON de la sauvegarde ici';

  @override
  String get restoreFromPasted => 'Restaurer depuis la sauvegarde collée';

  @override
  String get restoreBackupQ => 'Restaurer la sauvegarde ?';

  @override
  String get restoreReplaceWarning =>
      'Cela remplace tous les calendriers et événements actuels.';

  @override
  String get restored => 'Restauré';

  @override
  String get restoredMsg =>
      'Vos données ont été restaurées depuis la sauvegarde.';

  @override
  String get restoreFailed => 'Échec de la restauration';

  @override
  String get restoreEvents => 'Restaurer des événements';

  @override
  String get nothingToRestore => 'Rien à restaurer';

  @override
  String get restoreAll => 'Tout restaurer';

  @override
  String get deleteAllPermanently => 'Tout supprimer définitivement';

  @override
  String get about => 'À propos';

  @override
  String get localFree => 'Local · gratuit';

  @override
  String get shareAsText => 'Partager en texte';

  @override
  String get shareAsIcs => 'Partager en fichier calendrier (.ics)';

  @override
  String get search => 'Rechercher';

  @override
  String get searchPlaceholder => 'Nom de l’événement, lieu et notes';

  @override
  String get searchAll => 'Tous';

  @override
  String get noMatches => 'Aucun résultat';

  @override
  String get goToToday => 'Aller à aujourd’hui';

  @override
  String get done => 'Terminé';

  @override
  String get tomorrow => 'Demain';

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count événements aujourd’hui',
      one: '1 événement aujourd’hui',
    );
    return '$_temp0';
  }

  @override
  String eventsTomorrow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count événements demain',
      one: '1 événement demain',
    );
    return '$_temp0';
  }
}
