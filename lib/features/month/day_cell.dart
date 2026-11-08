import 'package:flutter/cupertino.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/tokens.dart';
import '../../core/widgets/event_chip.dart';
import 'domain/event.dart';

/// One day in the month grid: date number + up to a few event chips, with the
/// normal / Saturday / Sunday / outside-month / today / selected states.
class DayCell extends StatelessWidget {
  final DateTime day;
  final List<Event> events;
  final bool outsideMonth;
  final bool isToday;
  final bool isSelected;
  final VoidCallback onTap;

  const DayCell({
    super.key,
    required this.day,
    required this.events,
    required this.outsideMonth,
    required this.isToday,
    required this.isSelected,
    required this.onTap,
  });

  static const _maxRows = 3;

  @override
  Widget build(BuildContext context) {
    final numberColor = _numberColor(context);
    final highlight = isSelected
        ? Tokens.brand.resolveFrom(context)
        : isToday
            ? CupertinoColors.systemGrey6.resolveFrom(context)
            : null;

    // Decide which chips fit: all if few, else (max-1) chips + "+N".
    final visible = <Widget>[];
    if (events.length <= _maxRows) {
      visible.addAll(events.map((e) => _chip(e)));
    } else {
      visible.addAll(events.take(_maxRows - 1).map((e) => _chip(e)));
      visible.add(MoreChip(events.length - (_maxRows - 1)));
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: highlight == null
            ? null
            : BoxDecoration(
                color: highlight,
                borderRadius: BorderRadius.circular(Tokens.rCell),
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),
            Text(
              '${day.day}',
              textAlign: TextAlign.center,
              style: AppText.dateNumber(
                context,
                color: isSelected
                    ? Tokens.onBrand.resolveFrom(context)
                    : numberColor,
                emphasized: isToday || isSelected,
              ),
            ),
            const SizedBox(height: 2),
            ...visible,
          ],
        ),
      ),
    );
  }

  Widget _chip(Event e) => EventChip(
        title: e.title,
        colorId: e.colorId,
        faded: outsideMonth,
        continuesLeft: e.occursOn(day.subtract(const Duration(days: 1))) && e.isMultiDay,
        continuesRight: e.occursOn(day.add(const Duration(days: 1))) && e.isMultiDay,
      );

  Color _numberColor(BuildContext c) {
    if (outsideMonth) return CupertinoColors.tertiaryLabel.resolveFrom(c);
    if (day.weekday == DateTime.sunday) return CupertinoColors.systemRed.resolveFrom(c);
    if (day.weekday == DateTime.saturday) {
      return CupertinoColors.secondaryLabel.resolveFrom(c);
    }
    return CupertinoColors.label.resolveFrom(c);
  }
}
