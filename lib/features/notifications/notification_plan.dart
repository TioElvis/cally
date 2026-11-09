import '../../core/time/recurrence.dart';
import '../../data/db/database.dart';
import '../../data/models.dart';
import '../../l10n/app_localizations.dart';

/// A notification to schedule. [key] is a stable string; adapters hash it to the
/// integer id the platform wants.
class PlannedNotification {
  final String key;
  final DateTime when;
  final String title;
  final String body;
  const PlannedNotification({
    required this.key,
    required this.when,
    required this.title,
    required this.body,
  });

  @override
  String toString() => 'PN($key @ $when: $title / $body)';
}

String _alertBody(AppLocalizations t, int minutes) {
  if (minutes == 0) return t.atTimeOfEvent;
  if (minutes % 60 == 0) return t.hoursBefore(minutes ~/ 60);
  return t.minutesBefore(minutes);
}

int countOnDay(List<EventRow> events, DateTime day) {
  final from = DateTime(day.year, day.month, day.day);
  final to = from.add(const Duration(days: 1));
  var n = 0;
  for (final e in events) {
    n += expand(e.start, e.end, recurrenceOf(e), from, to).length;
  }
  return n;
}

/// Build the notifications to schedule from the current events + settings over
/// [now, now + horizonDays]. Capped to [maxCount] (iOS keeps only 64 pending).
List<PlannedNotification> planNotifications({
  required List<EventRow> events,
  required AppSettings settings,
  required DateTime now,
  required AppLocalizations t,
  int horizonDays = 30,
  int maxCount = 60,
}) {
  final to = now.add(Duration(days: horizonDays));
  final out = <PlannedNotification>[];

  // Per-event alerts: explicit alert, or the default for the event's kind.
  for (final e in events) {
    final minutes = e.alertMinutes ??
        (e.allDay ? settings.defaultAlertAllDay : settings.defaultAlertTimed);
    if (minutes == null) continue;
    for (final occ in expand(e.start, e.end, recurrenceOf(e), now, to)) {
      final fireAt = occ.start.subtract(Duration(minutes: minutes));
      if (fireAt.isAfter(now)) {
        out.add(PlannedNotification(
          key: 'alert:${e.id}:${occ.start.millisecondsSinceEpoch}',
          when: fireAt,
          title: e.title,
          body: _alertBody(t, minutes),
        ));
      }
    }
  }

  // Daily digests, only on days that actually have events.
  for (var d = DateTime(now.year, now.month, now.day);
      d.isBefore(to);
      d = d.add(const Duration(days: 1))) {
    if (settings.digestMorningOn) {
      final fire = d.add(Duration(minutes: settings.digestMorningMin));
      final n = countOnDay(events, d);
      if (fire.isAfter(now) && n > 0) {
        out.add(PlannedNotification(
          key: 'digest:am:${d.millisecondsSinceEpoch}',
          when: fire,
          title: t.today,
          body: t.eventsToday(n),
        ));
      }
    }
    if (settings.digestEveningOn) {
      final fire = d.add(Duration(minutes: settings.digestEveningMin));
      final tomorrow = d.add(const Duration(days: 1));
      final n = countOnDay(events, tomorrow);
      if (fire.isAfter(now) && n > 0) {
        out.add(PlannedNotification(
          key: 'digest:pm:${d.millisecondsSinceEpoch}',
          when: fire,
          title: t.tomorrow,
          body: t.eventsTomorrow(n),
        ));
      }
    }
  }

  out.sort((a, b) => a.when.compareTo(b.when));
  return out.length <= maxCount ? out : out.sublist(0, maxCount);
}
