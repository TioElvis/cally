import 'month_grid.dart';

/// Recurrence frequency. M1 supports the common cases; multi-weekday and
/// "nth weekday of the month" style rules are deferred to M2.
enum Freq { none, daily, weekly, monthly, yearly }

/// How a series ends.
enum RecEndKind { never, until, count }

/// A compact recurrence rule stored flat on an event.
class Recurrence {
  final Freq freq;
  final int interval; // every N periods (>=1)
  final RecEndKind endKind;
  final DateTime? until; // inclusive date when endKind == until
  final int? count; // number of occurrences when endKind == count

  const Recurrence({
    this.freq = Freq.none,
    this.interval = 1,
    this.endKind = RecEndKind.never,
    this.until,
    this.count,
  });

  static const none = Recurrence();

  bool get repeats => freq != Freq.none;

  Recurrence copyWith({
    Freq? freq,
    int? interval,
    RecEndKind? endKind,
    DateTime? until,
    int? count,
    bool clearUntil = false,
    bool clearCount = false,
  }) =>
      Recurrence(
        freq: freq ?? this.freq,
        interval: interval ?? this.interval,
        endKind: endKind ?? this.endKind,
        until: clearUntil ? null : (until ?? this.until),
        count: clearCount ? null : (count ?? this.count),
      );
}

/// One concrete occurrence of a (possibly recurring) event.
class Occurrence {
  final DateTime start;
  final DateTime end;
  const Occurrence(this.start, this.end);
}

/// Advance [d] by [n] periods of [freq]. Month/year math clamps the day to the
/// last valid day (e.g. Jan 31 + 1 month → Feb 28/29).
DateTime advance(DateTime d, Freq freq, int n) {
  switch (freq) {
    case Freq.none:
      return d;
    case Freq.daily:
      return DateTime(d.year, d.month, d.day + n, d.hour, d.minute, d.second);
    case Freq.weekly:
      return DateTime(d.year, d.month, d.day + 7 * n, d.hour, d.minute, d.second);
    case Freq.monthly:
      return _addMonthsClamped(d, n);
    case Freq.yearly:
      return _addMonthsClamped(d, 12 * n);
  }
}

DateTime _addMonthsClamped(DateTime d, int months) {
  final total = d.year * 12 + (d.month - 1) + months;
  final y = total ~/ 12;
  final m = total % 12 + 1;
  final lastDay = DateTime(y, m + 1, 0).day; // day 0 of next month = last day
  final day = d.day <= lastDay ? d.day : lastDay;
  return DateTime(y, m, day, d.hour, d.minute, d.second);
}

/// Expand a series into the occurrences overlapping the window [from, to)
/// (half-open). [start]/[end] are the first occurrence; [rec] its rule.
/// A non-repeating event yields its single occurrence if it overlaps.
List<Occurrence> expand(
  DateTime start,
  DateTime end,
  Recurrence rec,
  DateTime from,
  DateTime to, {
  int safetyCap = 1000,
}) {
  final duration = end.difference(start);

  if (!rec.repeats) {
    if (start.isBefore(to) && end.isAfter(from)) return [Occurrence(start, end)];
    return const [];
  }

  final out = <Occurrence>[];
  final interval = rec.interval < 1 ? 1 : rec.interval;
  final untilExclusive =
      rec.endKind == RecEndKind.until && rec.until != null
          ? dateOnly(rec.until!).add(const Duration(days: 1)) // inclusive date
          : null;

  // Each occurrence is computed from the ORIGINAL start (start + k periods), so
  // month/year clamping never drifts (Jan 31 → Feb 28 → Mar 31, not Mar 28).
  for (var k = 0; k < safetyCap; k++) {
    if (rec.endKind == RecEndKind.count && k >= (rec.count ?? 0)) break;
    final occStart = advance(start, rec.freq, interval * k);
    if (untilExclusive != null && !occStart.isBefore(untilExclusive)) break;
    if (!occStart.isBefore(to)) break; // past the window
    final occEnd = occStart.add(duration);
    if (occEnd.isAfter(from)) out.add(Occurrence(occStart, occEnd));
  }
  return out;
}
