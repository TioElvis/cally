import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/recurrence.dart';

void main() {
  final wideFrom = DateTime(2000);
  final wideTo = DateTime(2100);

  test('non-repeating event yields one occurrence only when it overlaps', () {
    final s = DateTime(2026, 11, 10, 9);
    final e = DateTime(2026, 11, 10, 10);
    expect(expand(s, e, Recurrence.none, wideFrom, wideTo).length, 1);
    expect(expand(s, e, Recurrence.none, DateTime(2026, 11, 11), wideTo), isEmpty);
  });

  test('daily with count=3 gives three consecutive days', () {
    final s = DateTime(2026, 11, 10, 9);
    final occ = expand(s, s.add(const Duration(hours: 1)),
        const Recurrence(freq: Freq.daily, endKind: RecEndKind.count, count: 3),
        wideFrom, wideTo);
    expect(occ.length, 3);
    expect(occ[0].start, DateTime(2026, 11, 10, 9));
    expect(occ[2].start, DateTime(2026, 11, 12, 9));
  });

  test('weekly honours an inclusive until date', () {
    final s = DateTime(2026, 11, 2, 18); // a Monday
    final occ = expand(s, s.add(const Duration(hours: 1)),
        Recurrence(freq: Freq.weekly, endKind: RecEndKind.until, until: DateTime(2026, 11, 16)),
        wideFrom, wideTo);
    // Nov 2, 9, 16 — all on/before the 16th
    expect(occ.map((o) => o.start.day), [2, 9, 16]);
  });

  test('monthly clamps the day (Jan 31 -> Feb 28 2026)', () {
    final s = DateTime(2026, 1, 31, 8);
    final occ = expand(s, s.add(const Duration(hours: 1)),
        const Recurrence(freq: Freq.monthly, endKind: RecEndKind.count, count: 3),
        wideFrom, wideTo);
    expect(occ[0].start, DateTime(2026, 1, 31, 8));
    expect(occ[1].start, DateTime(2026, 2, 28, 8));
    expect(occ[2].start, DateTime(2026, 3, 31, 8));
  });

  test('interval and window both apply', () {
    final s = DateTime(2026, 11, 1, 9);
    // every 2 days; only ask for a 5-day window -> days 1,3,5
    final occ = expand(s, s.add(const Duration(hours: 1)),
        const Recurrence(freq: Freq.daily, interval: 2),
        DateTime(2026, 11, 1), DateTime(2026, 11, 6));
    expect(occ.map((o) => o.start.day), [1, 3, 5]);
  });

  test('yearly advances by a year and clamps leap day', () {
    final s = DateTime(2024, 2, 29, 12); // leap day
    final occ = expand(s, s.add(const Duration(hours: 1)),
        const Recurrence(freq: Freq.yearly, endKind: RecEndKind.count, count: 2),
        wideFrom, wideTo);
    expect(occ[0].start, DateTime(2024, 2, 29, 12));
    expect(occ[1].start, DateTime(2025, 2, 28, 12));
  });
}
