import '../../core/time/month_grid.dart';

/// What a widget tap / deep link asks the app to do.
sealed class WidgetAction {
  const WidgetAction();
}

/// Open the app on today.
class OpenToday extends WidgetAction {
  const OpenToday();
}

/// Open the app on a specific day.
class OpenDay extends WidgetAction {
  final DateTime day;
  const OpenDay(this.day);
}

/// Open the new-event editor (optionally on a day).
class NewEvent extends WidgetAction {
  final DateTime? day;
  const NewEvent(this.day);
}

/// Parse a `cally://` deep link into an action. Recognized forms:
///   cally://today
///   cally://day/2026-11-20
///   cally://new            or   cally://new/2026-11-20
/// Anything unrecognized → [OpenToday].
WidgetAction parseDeepLink(Uri? uri) {
  if (uri == null || uri.scheme != 'cally') return const OpenToday();
  final host = uri.host.isNotEmpty ? uri.host : (uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '');
  final rest = uri.host.isNotEmpty ? uri.pathSegments : uri.pathSegments.skip(1).toList();

  switch (host) {
    case 'today':
      return const OpenToday();
    case 'day':
      final d = _parseDate(rest.isNotEmpty ? rest.first : null);
      return d == null ? const OpenToday() : OpenDay(d);
    case 'new':
      return NewEvent(_parseDate(rest.isNotEmpty ? rest.first : null));
    default:
      return const OpenToday();
  }
}

DateTime? _parseDate(String? s) {
  if (s == null) return null;
  final d = DateTime.tryParse(s);
  return d == null ? null : dateOnly(d);
}
