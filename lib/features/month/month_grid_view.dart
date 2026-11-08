import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import '../../core/time/iso_week.dart';
import '../../core/time/month_grid.dart';
import '../../data/models.dart';
import 'day_cell.dart';
import 'month_providers.dart';

const double weekColWidth = 22;

/// One month page: a fixed 6×7 grid of [DayCell]s, fed by the store. With Pro +
/// the week-numbers setting, a leading ISO week-number column is shown.
class MonthGridView extends ConsumerWidget {
  final DateTime monthAnchor;
  final void Function(DateTime day) onSelectDay;

  const MonthGridView({
    super.key,
    required this.monthAnchor,
    required this.onSelectDay,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekStart = ref.watch(weekStartProvider);
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    final showWeeks = settings.weekNumbersEnabled;
    final occurrences = ref.watch(monthOccurrencesProvider(monthAnchor));
    final selected = ref.watch(selectedDayProvider);
    final today = dateOnly(DateTime.now());
    final days = monthGridDays(monthAnchor, weekStart);
    // Offset within a row that lands on Thursday (ISO week anchor).
    final thuOffset = (DateTime.thursday - weekStart + 7) % 7;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.gutterEdge),
      child: Column(
        children: List.generate(Tokens.gridRows, (row) {
          final rowDays = days.sublist(row * Tokens.gridCols, row * Tokens.gridCols + Tokens.gridCols);
          return SizedBox(
            height: Tokens.rowHeight,
            child: Row(
              children: [
                if (showWeeks)
                  SizedBox(
                    width: weekColWidth,
                    child: Center(
                      child: Text(
                        '${isoWeekNumber(rowDays[thuOffset])}',
                        style: TextStyle(
                          fontSize: 10,
                          color: CupertinoColors.tertiaryLabel.resolveFrom(context),
                        ),
                      ),
                    ),
                  ),
                for (final day in rowDays)
                  Expanded(
                    child: DayCell(
                      day: day,
                      events: _on(occurrences, day),
                      outsideMonth: !isSameMonth(day, monthAnchor),
                      isToday: isSameDay(day, today),
                      isSelected: isSameDay(day, selected),
                      onTap: () => onSelectDay(day),
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }

  List<DayOccurrence> _on(List<DayOccurrence> all, DateTime day) =>
      sortOccurrences(all.where((e) => e.occursOn(day)).toList());
}
