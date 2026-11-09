import '../../l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import '../../data/models.dart';
import '../month/month_providers.dart';

/// Manage calendars: visibility, default, colour/name, order, create, delete.
/// Cupertino-only (reorder via a per-calendar move up/down, no Material list).
class CalendarsPage extends ConsumerWidget {
  const CalendarsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final cals = ref.watch(calendarsProvider).value ?? const <Calendar>[];
    final repo = ref.read(repositoryProvider);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: Text(t.calendars),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => _editCalendar(context, ref, null),
          child: const Icon(CupertinoIcons.add),
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              children: [
                for (final c in cals)
                  CupertinoListTile(
                    leading: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: EventColors.base(c.colorId),
                        shape: BoxShape.circle,
                      ),
                    ),
                    title: Text(c.title),
                    subtitle: c.isDefault ? Text(t.defaultLabel) : null,
                    trailing: CupertinoSwitch(
                      value: c.isVisible,
                      onChanged: (v) => repo.setCalendarVisible(c.id, v),
                    ),
                    onTap: () => _calendarActions(context, ref, cals, c),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter),
              child: Text(
                t.calendarsHint,
                style: TextStyle(
                    fontSize: 13, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _calendarActions(
      BuildContext context, WidgetRef ref, List<Calendar> cals, Calendar cal) async {
    final t = AppLocalizations.of(context);
    final repo = ref.read(repositoryProvider);
    final index = cals.indexWhere((c) => c.id == cal.id);
    final action = await showCupertinoModalPopup<String>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: Text(cal.title),
        actions: [
          CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(c, 'edit'),
              child: Text(t.renameRecolour)),
          if (!cal.isDefault)
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(c, 'default'),
                child: Text(t.makeDefault)),
          if (index > 0)
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(c, 'up'), child: Text(t.moveUp)),
          if (index < cals.length - 1)
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(c, 'down'), child: Text(t.moveDown)),
          CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(c, 'delete'),
              child: Text(t.delete)),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: Text(t.cancel)),
      ),
    );
    switch (action) {
      case 'default':
        await repo.setDefaultCalendar(cal.id);
      case 'up':
      case 'down':
        final ids = cals.map((e) => e.id).toList();
        final to = action == 'up' ? index - 1 : index + 1;
        final moved = ids.removeAt(index);
        ids.insert(to, moved);
        await repo.reorderCalendars(ids);
      case 'delete':
        if (!context.mounted) return;
        if (await _confirmDelete(context, cal.title)) await repo.deleteCalendar(cal.id);
      case 'edit':
        if (!context.mounted) return;
        await showCupertinoModalPopup<void>(
          context: context,
          builder: (_) => _CalendarEditor(cal: cal),
        );
    }
  }

  Future<void> _editCalendar(BuildContext context, WidgetRef ref, Calendar? cal) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (_) => _CalendarEditor(cal: cal),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, String title) async {
    final t = AppLocalizations.of(context);
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(t.deleteCalendarQ(title)),
        content: Text(t.calendarEventsDeleted),
        actions: [
          CupertinoDialogAction(
              onPressed: () => Navigator.pop(c, false), child: Text(t.cancel)),
          CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(c, true),
              child: Text(t.delete)),
        ],
      ),
    );
    return ok ?? false;
  }
}

class _CalendarEditor extends ConsumerStatefulWidget {
  final Calendar? cal;
  const _CalendarEditor({this.cal});

  @override
  ConsumerState<_CalendarEditor> createState() => _CalendarEditorState();
}

class _CalendarEditorState extends ConsumerState<_CalendarEditor> {
  late final TextEditingController _name;
  late int _colorId;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.cal?.title ?? '');
    _colorId = widget.cal?.colorId ?? 0;
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final h = MediaQuery.sizeOf(context).height;
    return Padding(
      padding: EdgeInsets.only(top: h * 0.3),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(Tokens.rSheet)),
        child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            leading: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Text(t.cancel)),
            middle: Text(widget.cal == null ? t.newCalendar : t.editCalendar),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                await ref.read(repositoryProvider).saveCalendar(
                    id: widget.cal?.id, title: _name.text, colorId: _colorId);
                if (context.mounted) Navigator.pop(context);
              },
              child: Text(t.save, style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          child: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(Tokens.gutter),
              children: [
                CupertinoTextField(
                  controller: _name,
                  autofocus: widget.cal == null,
                  placeholder: t.calendarName,
                  padding: const EdgeInsets.all(14),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 14,
                  runSpacing: 14,
                  children: List.generate(EventColors.palette.length, (i) {
                    final selected = _colorId == i;
                    return GestureDetector(
                      onTap: () => setState(() => _colorId = i),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: EventColors.palette[i],
                          shape: BoxShape.circle,
                          border: selected
                              ? Border.all(
                                  color: CupertinoColors.label.resolveFrom(context), width: 3)
                              : null,
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
