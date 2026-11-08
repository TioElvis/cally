// Pure date math for the month view. No Flutter, fully unit-testable.

/// Midnight of [d] in local time.
DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// First day of the month [d] belongs to.
DateTime firstOfMonth(DateTime d) => DateTime(d.year, d.month, 1);

/// Add [months] to a month anchor, staying on day 1.
DateTime addMonths(DateTime monthAnchor, int months) {
  final total = monthAnchor.year * 12 + (monthAnchor.month - 1) + months;
  return DateTime(total ~/ 12, total % 12 + 1, 1);
}

/// Whole-month difference between two month anchors (a - b).
int monthsBetween(DateTime a, DateTime b) =>
    (a.year - b.year) * 12 + (a.month - b.month);

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool isSameMonth(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month;

/// The 42 days (6×7) shown for [month], including spill-over from the previous
/// and next months. [weekStart] uses `DateTime.monday`..`DateTime.sunday` (1..7).
List<DateTime> monthGridDays(DateTime month, int weekStart) {
  final first = firstOfMonth(month);
  // How many leading days from the previous month to reach [weekStart].
  final lead = (first.weekday - weekStart + 7) % 7;
  final start = first.subtract(Duration(days: lead));
  return List<DateTime>.generate(42, (i) => DateTime(start.year, start.month, start.day + i));
}

/// Weekday header letters' DateTime.weekday values, ordered from [weekStart].
List<int> weekdayOrder(int weekStart) =>
    List<int>.generate(7, (i) => (weekStart - 1 + i) % 7 + 1);
