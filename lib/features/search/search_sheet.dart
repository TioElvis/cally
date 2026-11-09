import '../../l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import '../../core/time/formats.dart';
import '../../data/db/database.dart';
import 'search_logic.dart';
import '../../data/models.dart';
import '../event_editor/event_editor_sheet.dart';
import '../month/month_providers.dart';

Future<void> showSearch(BuildContext context) {
  return showCupertinoModalPopup<void>(
    context: context,
    builder: (_) => const _SearchFrame(child: SearchSheet()),
  );
}

class _SearchFrame extends StatelessWidget {
  final Widget child;
  const _SearchFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(top: h * 0.06),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Tokens.rSheet)),
        child: SizedBox(height: h * 0.94, child: child),
      ),
    );
  }
}

class SearchSheet extends ConsumerStatefulWidget {
  const SearchSheet({super.key});

  @override
  ConsumerState<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends ConsumerState<SearchSheet> {
  String _query = '';
  String? _calendarFilter; // null = all

  List<EventRow> _results(List<EventRow> rows) =>
      matchEvents(rows, query: _query, calendarId: _calendarFilter);

  @override
  Widget build(BuildContext context) {
    final rows = ref.watch(eventRowsProvider).value ?? const [];
    final cals = ref.watch(calendarsProvider).value ?? const <Calendar>[];
    final use24h = ref.watch(use24hProvider);
    final t = AppLocalizations.of(context);
    final results = _results(rows);

    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Tokens.gutter, 12, 8, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(t.search,
                        style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pop(context),
                    child: const Icon(CupertinoIcons.xmark_circle_fill, size: 28),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter),
              child: CupertinoSearchTextField(
                autofocus: true,
                placeholder: t.searchPlaceholder,
                onChanged: (v) => setState(() => _query = v),
              ),
            ),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter, vertical: 8),
                children: [
                  _FilterChip(
                    label: t.searchAll,
                    selected: _calendarFilter == null,
                    color: null,
                    onTap: () => setState(() => _calendarFilter = null),
                  ),
                  for (final c in cals)
                    _FilterChip(
                      label: c.title,
                      selected: _calendarFilter == c.id,
                      color: EventColors.base(c.colorId),
                      onTap: () => setState(() => _calendarFilter = c.id),
                    ),
                ],
              ),
            ),
            Expanded(
              child: _query.trim().isEmpty
                  ? const SizedBox.shrink()
                  : results.isEmpty
                      ? Center(
                          child: Text(t.noMatches,
                              style: TextStyle(
                                  color: CupertinoColors.secondaryLabel.resolveFrom(context))))
                      : ListView.separated(
                          itemCount: results.length,
                          separatorBuilder: (_, _) => Container(
                            height: 0.5,
                            margin: const EdgeInsets.only(left: Tokens.gutter),
                            color: CupertinoColors.separator.resolveFrom(context),
                          ),
                          itemBuilder: (context, i) {
                            final r = results[i];
                            final color = r.colorId ??
                                cals
                                    .cast<Calendar?>()
                                    .firstWhere((c) => c?.id == r.calendarId,
                                        orElse: () => null)
                                    ?.colorId ??
                                0;
                            return _ResultRow(
                              row: r,
                              colorId: color,
                              use24h: use24h,
                              onTap: () => showEventEditor(context, EventDraft.fromRow(r)),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? color;
  final VoidCallback onTap;
  const _FilterChip(
      {required this.label, required this.selected, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final bg = selected
        ? CupertinoColors.label.resolveFrom(context)
        : CupertinoColors.systemGrey6.resolveFrom(context);
    final fg = selected
        ? CupertinoColors.systemBackground.resolveFrom(context)
        : CupertinoColors.label.resolveFrom(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(Tokens.rPill)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (color != null) ...[
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 6),
            ],
            Text(label, style: TextStyle(color: fg, fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final EventRow row;
  final int colorId;
  final bool use24h;
  final VoidCallback onTap;
  const _ResultRow(
      {required this.row, required this.colorId, required this.use24h, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final when = row.allDay ? fmtDate(row.start) : fmtDateTime(row.start, use24h);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 34,
              decoration:
                  BoxDecoration(color: EventColors.base(colorId), borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(when,
                      style: TextStyle(
                          fontSize: 13,
                          color: CupertinoColors.secondaryLabel.resolveFrom(context))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
