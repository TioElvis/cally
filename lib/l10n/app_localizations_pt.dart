// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get today => 'Hoje';

  @override
  String get newEvent => 'Novo evento';

  @override
  String get noEvents => 'Sem eventos';

  @override
  String get allDay => 'Dia inteiro';

  @override
  String get eventName => 'Nome do evento';

  @override
  String get starts => 'Começa';

  @override
  String get ends => 'Termina';

  @override
  String get calendar => 'Calendário';

  @override
  String get color => 'Cor';

  @override
  String get repeat => 'Repetir';

  @override
  String get alert => 'Alerta';

  @override
  String get notes => 'Notas';

  @override
  String get deleteEvent => 'Eliminar evento';

  @override
  String get deleteEventQ => 'Eliminar o evento?';

  @override
  String get deleteSeriesNote => 'Isto elimina toda a série repetida.';

  @override
  String get repeatNever => 'Não se repete';

  @override
  String get repeatDaily => 'Todos os dias';

  @override
  String get repeatWeekly => 'Todas as semanas';

  @override
  String get repeatMonthly => 'Todos os meses';

  @override
  String get repeatYearly => 'Todos os anos';

  @override
  String get alertNone => 'Nenhum';

  @override
  String get atTimeOfEvent => 'Na hora do evento';

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
  String get appearance => 'Aparência';

  @override
  String get theme => 'Tema';

  @override
  String get system => 'Sistema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get firstDayOfWeek => 'Primeiro dia da semana';

  @override
  String get use24h => 'Formato de 24 horas';

  @override
  String get weekNumbers => 'Números de semana';

  @override
  String get accentColor => 'Cor de destaque';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Padrão do sistema';

  @override
  String get notifications => 'Notificações';

  @override
  String get enableNotifications => 'Ativar notificações';

  @override
  String get defaultAlert => 'Alerta predefinido';

  @override
  String get defaultAlertAllDay => 'Alerta predefinido (dia inteiro)';

  @override
  String get morningDigest => 'Resumo da manhã';

  @override
  String get eveningDigest => 'Resumo da noite (amanhã)';

  @override
  String get appIconBadge => 'Selo no ícone';

  @override
  String get badgeNone => 'Nenhum';

  @override
  String get badgeDate => 'Data';

  @override
  String get badgeCount => 'Contagem';

  @override
  String get notificationsEnabled => 'Notificações ativadas';

  @override
  String get notificationsOff => 'Notificações desativadas';

  @override
  String get notificationsOnMsg => 'O Cally já pode lembrar os teus eventos.';

  @override
  String get notificationsOffMsg =>
      'Permite as notificações nas definições do sistema para receber alertas.';

  @override
  String get settings => 'Definições';

  @override
  String get calendars => 'Calendários';

  @override
  String get manageCalendars => 'Gerir calendários';

  @override
  String get newCalendar => 'Novo calendário';

  @override
  String get editCalendar => 'Editar calendário';

  @override
  String get calendarName => 'Nome do calendário';

  @override
  String get renameRecolour => 'Renomear / mudar cor';

  @override
  String get makeDefault => 'Tornar predefinido';

  @override
  String get moveUp => 'Mover para cima';

  @override
  String get moveDown => 'Mover para baixo';

  @override
  String get defaultLabel => 'Predefinido';

  @override
  String deleteCalendarQ(String title) {
    return 'Eliminar “$title”?';
  }

  @override
  String get calendarEventsDeleted => 'Os seus eventos também são eliminados.';

  @override
  String get calendarsHint =>
      'Toca num calendário para o renomear, mudar a cor, reordenar, definir como predefinido ou eliminar. O interruptor oculta-o da grelha.';

  @override
  String get data => 'Dados';

  @override
  String get backupRestore => 'Cópia e restauro';

  @override
  String get backup => 'Cópia';

  @override
  String get restoreTitle => 'Restaurar';

  @override
  String get exportToClipboard => 'Exportar para a área de transferência';

  @override
  String get backupCopied => 'Cópia copiada';

  @override
  String backupCopiedMsg(int count) {
    return 'Os teus dados ($count caracteres) estão na área de transferência. Cola-os num local seguro ou em Restaurar noutro dispositivo.';
  }

  @override
  String get backupFooter =>
      'Copia todos os teus calendários, eventos e definições como JSON para a área de transferência. Guarda-o ou cola-o em Restaurar noutro dispositivo.';

  @override
  String get restoreFooter =>
      'Cola uma cópia do Cally e restaura-a. Isto substitui tudo o que está na app.';

  @override
  String get pasteBackupHere => 'Cola aqui o JSON da cópia';

  @override
  String get restoreFromPasted => 'Restaurar a partir da cópia colada';

  @override
  String get restoreBackupQ => 'Restaurar a cópia?';

  @override
  String get restoreReplaceWarning =>
      'Isto substitui todos os calendários e eventos atuais.';

  @override
  String get restored => 'Restaurado';

  @override
  String get restoredMsg =>
      'Os teus dados foram restaurados a partir da cópia.';

  @override
  String get restoreFailed => 'Falha ao restaurar';

  @override
  String get restoreEvents => 'Restaurar eventos';

  @override
  String get nothingToRestore => 'Nada para restaurar';

  @override
  String get restoreAll => 'Restaurar tudo';

  @override
  String get deleteAllPermanently => 'Eliminar tudo permanentemente';

  @override
  String get about => 'Acerca';

  @override
  String get localFree => 'Local · grátis';

  @override
  String get shareAsText => 'Partilhar como texto';

  @override
  String get shareAsIcs => 'Partilhar como ficheiro de calendário (.ics)';

  @override
  String get search => 'Pesquisar';

  @override
  String get searchPlaceholder => 'Nome do evento, local e notas';

  @override
  String get searchAll => 'Todos';

  @override
  String get noMatches => 'Sem resultados';

  @override
  String get goToToday => 'Ir para hoje';

  @override
  String get done => 'Concluído';

  @override
  String get tomorrow => 'Amanhã';

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos hoje',
      one: '1 evento hoje',
    );
    return '$_temp0';
  }

  @override
  String eventsTomorrow(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventos amanhã',
      one: '1 evento amanhã',
    );
    return '$_temp0';
  }
}
