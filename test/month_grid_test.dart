import 'package:flutter_test/flutter_test.dart';
import 'package:cally/core/time/month_grid.dart';

void main() {
  test('month grid is always 42 days and starts on the week start', () {
    final march = DateTime(2026, 3, 1); // a Sunday
    final mon = monthGridDays(march, DateTime.monday);
    expect(mon.length, 42);
    expect(mon.first.weekday, DateTime.monday);
    expect(mon.last.weekday, DateTime.sunday);
    // 1 March 2026 is a Sunday → with Monday-start there are 6 lead days.
    expect(mon[6], DateTime(2026, 3, 1));

    final sun = monthGridDays(march, DateTime.sunday);
    expect(sun.first.weekday, DateTime.sunday);
    expect(sun.first, DateTime(2026, 3, 1)); // no lead days with Sunday start
  });

  test('addMonths and monthsBetween round-trip across year boundaries', () {
    final base = DateTime(2026, 11, 1);
    expect(addMonths(base, 2), DateTime(2027, 1, 1));
    expect(addMonths(base, -11), DateTime(2025, 12, 1));
    expect(monthsBetween(addMonths(base, 5), base), 5);
    expect(monthsBetween(addMonths(base, -7), base), -7);
  });

  test('same day / month helpers', () {
    expect(isSameDay(DateTime(2026, 1, 2, 9), DateTime(2026, 1, 2, 23)), true);
    expect(isSameDay(DateTime(2026, 1, 2), DateTime(2026, 1, 3)), false);
    expect(isSameMonth(DateTime(2026, 1, 31), DateTime(2026, 1, 1)), true);
    expect(isSameMonth(DateTime(2026, 1, 31), DateTime(2026, 2, 1)), false);
  });

  test('weekdayOrder rotates from the week start', () {
    expect(weekdayOrder(DateTime.monday), [1, 2, 3, 4, 5, 6, 7]);
    expect(weekdayOrder(DateTime.sunday), [7, 1, 2, 3, 4, 5, 6]);
  });
}
