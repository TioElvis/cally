import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import '../../core/time/month_grid.dart';
import 'day_cell.dart';
import 'domain/event.dart';
import 'month_providers.dart';

/// One month page: a fixed 6×7 grid of [DayCell]s.
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
    final events = ref.watch(eventsProvider);
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
                    events: _eventsOn(events, day),
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

  List<Event> _eventsOn(List<Event> all, DateTime day) {
    final out = all.where((e) => e.occursOn(day)).toList()
      ..sort((a, b) {
        if (a.allDay != b.allDay) return a.allDay ? -1 : 1;
        return a.start.compareTo(b.start);
      });
    return out;
  }
}
