// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Cally';

  @override
  String get cancel => 'Cancelar';

  @override
  String get ok => 'OK';

  @override
  String get save => 'Guardar';

  @override
  String get delete => 'Eliminar';

  @override
  String get edit => 'Editar';

  @override
  String get restore => 'Restaurar';

  @override
  String get today => 'Hoy';

  @override
  String get newEvent => 'Nuevo evento';

  @override
  String get noEvents => 'Sin eventos';

  @override
  String get allDay => 'Todo el día';

  @override
  String get eventName => 'Nombre del evento';

  @override
  String get starts => 'Empieza';

  @override
  String get ends => 'Termina';

  @override
  String get calendar => 'Calendario';

  @override
  String get color => 'Color';

  @override
  String get repeat => 'Repetir';

  @override
  String get alert => 'Aviso';

  @override
  String get notes => 'Notas';

  @override
  String get deleteEvent => 'Eliminar evento';

  @override
  String get deleteEventQ => '¿Eliminar el evento?';

  @override
  String get deleteSeriesNote => 'Esto elimina toda la serie repetida.';

  @override
  String get repeatNever => 'No se repite';

  @override
  String get repeatDaily => 'Cada día';

  @override
  String get repeatWeekly => 'Cada semana';

  @override
  String get repeatMonthly => 'Cada mes';

  @override
  String get repeatYearly => 'Cada año';

  @override
  String get alertNone => 'Ninguno';

  @override
  String get atTimeOfEvent => 'A la hora del evento';

  @override
  String minutesBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutos antes',
      one: '1 minuto antes',
    );
    return '$_temp0';
  }

  @override
  String hoursBefore(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count horas antes',
      one: '1 hora antes',
    );
    return '$_temp0';
  }

  @override
  String get appearance => 'Apariencia';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get firstDayOfWeek => 'Primer día de la semana';

  @override
  String get use24h => 'Formato de 24 horas';

  @override
  String get weekNumbers => 'Números de semana';

  @override
  String get accentColor => 'Color de acento';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Predeterminado del sistema';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get enableNotifications => 'Activar notificaciones';

  @override
  String get defaultAlert => 'Aviso predeterminado';

  @override
  String get defaultAlertAllDay => 'Aviso predeterminado (todo el día)';

  @override
  String get morningDigest => 'Resumen de la mañana';

  @override
  String get eveningDigest => 'Resumen de la noche (mañana)';

  @override
  String get appIconBadge => 'Globo en el icono';

  @override
  String get badgeNone => 'Ninguno';

  @override
  String get badgeDate => 'Fecha';

  @override
  String get badgeCount => 'Cantidad';

  @override
  String get notificationsEnabled => 'Notificaciones activadas';

  @override
  String get notificationsOff => 'Notificaciones desactivadas';

  @override
  String get notificationsOnMsg => 'Cally ya puede recordarte tus eventos.';

  @override
  String get notificationsOffMsg =>
      'Permite las notificaciones en los ajustes del sistema para recibir avisos.';

  @override
  String get settings => 'Ajustes';

  @override
  String get calendars => 'Calendarios';

  @override
  String get manageCalendars => 'Gestionar calendarios';

  @override
  String get newCalendar => 'Nuevo calendario';

  @override
  String get editCalendar => 'Editar calendario';

  @override
  String get calendarName => 'Nombre del calendario';

  @override
  String get renameRecolour => 'Renombrar / cambiar color';

  @override
  String get makeDefault => 'Predeterminado';

  @override
  String get moveUp => 'Subir';

  @override
  String get moveDown => 'Bajar';

  @override
  String get defaultLabel => 'Predeterminado';

  @override
  String deleteCalendarQ(String title) {
    return '¿Eliminar “$title”?';
  }

  @override
  String get calendarEventsDeleted => 'Sus eventos también se eliminan.';

  @override
  String get calendarsHint =>
      'Toca un calendario para renombrarlo, cambiar su color, reordenarlo, marcarlo como predeterminado o eliminarlo. El interruptor lo oculta de la cuadrícula.';

  @override
  String get data => 'Datos';

  @override
  String get backupRestore => 'Copia y restauración';

  @override
  String get backup => 'Copia';

  @override
  String get restoreTitle => 'Restaurar';

  @override
  String get exportToClipboard => 'Exportar al portapapeles';

  @override
  String get backupCopied => 'Copia realizada';

  @override
  String backupCopiedMsg(int count) {
    return 'Tus datos ($count caracteres) están en el portapapeles. Pégalos en un lugar seguro o en Restaurar en otro dispositivo.';
  }

  @override
  String get backupFooter =>
      'Copia todos tus calendarios, eventos y ajustes como JSON al portapapeles. Guárdalo o pégalo en Restaurar en otro dispositivo.';

  @override
  String get restoreFooter =>
      'Pega una copia de Cally y restáurala. Esto reemplaza todo lo que hay en la app.';

  @override
  String get pasteBackupHere => 'Pega aquí el JSON de la copia';

  @override
  String get restoreFromPasted => 'Restaurar desde la copia pegada';

  @override
  String get restoreBackupQ => '¿Restaurar la copia?';

  @override
  String get restoreReplaceWarning =>
      'Esto reemplaza todos los calendarios y eventos actuales.';

  @override
  String get restored => 'Restaurado';

  @override
  String get restoredMsg => 'Tus datos se restauraron desde la copia.';

  @override
  String get restoreFailed => 'La restauración falló';

  @override
  String get restoreEvents => 'Restaurar eventos';

  @override
  String get nothingToRestore => 'Nada que restaurar';

  @override
  String get restoreAll => 'Restaurar todo';

  @override
  String get deleteAllPermanently => 'Eliminar todo permanentemente';

  @override
  String get about => 'Acerca de';

  @override
  String get localFree => 'Local · gratis';

  @override
  String get shareAsText => 'Compartir como texto';

  @override
  String get shareAsIcs => 'Compartir como archivo de calendario (.ics)';

  @override
  String get search => 'Buscar';

  @override
  String get searchPlaceholder => 'Nombre del evento, lugar y notas';

  @override
  String get searchAll => 'Todos';

  @override
  String get noMatches => 'Sin resultados';

  @override
  String get goToToday => 'Ir a hoy';

  @override
  String get done => 'Hecho';

  @override
  String get tomorrow => 'Mañana';

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos hoy',
      one: '1 evento hoy',
    );
    return '$_temp0';
  }

  @override
  String eventsTomorrow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos mañana',
      one: '1 evento mañana',
    );
    return '$_temp0';
  }
}
