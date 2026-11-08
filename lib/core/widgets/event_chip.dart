import 'package:flutter/cupertino.dart';

import '../theme/tokens.dart';
import '../theme/app_theme.dart';

/// One-line event chip: a colour bar + tinted background + darkened text.
/// Derives all three tones from a single base colour (see [EventColors]).
class EventChip extends StatelessWidget {
  final String title;
  final int colorId;
  final bool faded; // out-of-month day
  final bool continuesLeft; // multi-day span: no rounded left / no title
  final bool continuesRight;

  const EventChip({
    super.key,
    required this.title,
    required this.colorId,
    this.faded = false,
    this.continuesLeft = false,
    this.continuesRight = false,
  });

  @override
  Widget build(BuildContext context) {
    final tones = EventColors.of(context, colorId, faded: faded);
    final radius = Radius.circular(Tokens.rChip);
    return Container(
      height: 15,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        color: tones.background,
        borderRadius: BorderRadius.horizontal(
          left: continuesLeft ? Radius.zero : radius,
          right: continuesRight ? Radius.zero : radius,
        ),
      ),
      child: Row(
        children: [
          if (!continuesLeft)
            Container(
              width: 2.5,
              margin: const EdgeInsets.symmetric(vertical: 1),
              color: tones.bar,
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 3, right: 2),
              child: Text(
                continuesLeft ? '' : title,
                maxLines: 1,
                overflow: TextOverflow.clip,
                softWrap: false,
                style: AppText.chip.copyWith(color: tones.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The "+N" overflow marker shown when a cell has more events than fit.
class MoreChip extends StatelessWidget {
  final int count;
  const MoreChip(this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, top: 1),
      child: Text(
        '+$count',
        style: AppText.chip.copyWith(
          color: CupertinoColors.secondaryLabel.resolveFrom(context),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
