import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import '../../core/time/month_grid.dart';
import '../../data/models.dart';
import 'day_cell.dart';
import 'month_providers.dart';

/// One month page: a fixed 6×7 grid of [DayCell]s, fed by the store.
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
    final occurrences = ref.watch(monthOccurrencesProvider(monthAnchor));
    final selected = ref.watch(selectedDayProvider);
    final today = dateOnly(DateTime.now());
    final days = monthGridDays(monthAnchor, weekStart);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.gutterEdge),
      child: Column(
        children: List.generate(Tokens.gridRows, (row) {
          return SizedBox(
            height: Tokens.rowHeight,
            child: Row(
              children: List.generate(Tokens.gridCols, (col) {
                final day = days[row * Tokens.gridCols + col];
                return Expanded(
                  child: DayCell(
                    day: day,
                    events: _on(occurrences, day),
                    outsideMonth: !isSameMonth(day, monthAnchor),
                    isToday: isSameDay(day, today),
                    isSelected: isSameDay(day, selected),
                    onTap: () => onSelectDay(day),
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }

  List<DayOccurrence> _on(List<DayOccurrence> all, DateTime day) =>
      sortOccurrences(all.where((e) => e.occursOn(day)).toList());
}
