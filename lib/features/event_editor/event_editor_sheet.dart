import '../../l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/tokens.dart';
import '../../core/time/formats.dart';
import '../../core/time/recurrence.dart';
import '../../data/models.dart';
import '../month/month_providers.dart';

/// Present the editor as an iOS-style modal sheet. Returns when dismissed.
Future<void> showEventEditor(BuildContext context, EventDraft draft) {
  return showCupertinoModalPopup<void>(
    context: context,
    barrierDismissible: true,
    builder: (context) => _SheetFrame(child: EventEditorSheet(draft: draft)),
  );
}

class _SheetFrame extends StatelessWidget {
  final Widget child;
  const _SheetFrame({required this.child});

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

class EventEditorSheet extends ConsumerStatefulWidget {
  final EventDraft draft;
  const EventEditorSheet({super.key, required this.draft});

  @override
  ConsumerState<EventEditorSheet> createState() => _EventEditorSheetState();
}

class _EventEditorSheetState extends ConsumerState<EventEditorSheet> {
  late EventDraft d;
  late final TextEditingController _title;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    d = widget.draft;
    _title = TextEditingController(text: d.title);
    _notes = TextEditingController(text: d.notes ?? '');
  }

  @override
  void dispose() {
    _title.dispose();
    _notes.dispose();
    super.dispose();
  }

  bool get _isEditing => d.id != null;

  Future<void> _save() async {
    d.title = _title.text;
    d.notes = _notes.text;
    if (d.end.isBefore(d.start)) d.end = d.start.add(const Duration(hours: 1));
    await ref.read(repositoryProvider).save(d);
    HapticFeedback.mediumImpact();
    if (mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final t = AppLocalizations.of(context);
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(t.deleteEventQ),
        content: d.recurrence.repeats
            ? Text(t.deleteSeriesNote)
            : null,
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
    if (ok == true) {
      await ref.read(repositoryProvider).delete(d.id!);
      HapticFeedback.mediumImpact();
      if (mounted) Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cals = ref.watch(calendarsProvider).value ?? const [];
    final use24h = ref.watch(use24hProvider);
    final t = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: Text(t.cancel),
        ),
        middle: Text(_isEditing ? t.edit : t.newEvent),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _save,
          child: Text(t.save, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Tokens.gutter, 8, Tokens.gutter, 8),
              child: CupertinoTextField(
                controller: _title,
                autofocus: !_isEditing,
                placeholder: t.eventName,
                decoration: null,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                placeholderStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: CupertinoColors.placeholderText.resolveFrom(context),
                ),
              ),
            ),
            _Group(children: [
              _ToggleRow(
                icon: CupertinoIcons.clock,
                label: t.allDay,
                value: d.allDay,
                onChanged: (v) => setState(() => d.allDay = v),
              ),
              _TapRow(
                icon: CupertinoIcons.calendar,
                label: t.starts,
                value: _fmt(d.start, d.allDay, use24h),
                onTap: () => _pickStart(),
              ),
              if (!d.allDay)
                _TapRow(
                  icon: null,
                  label: t.ends,
                  value: _fmt(d.end, d.allDay, use24h),
                  onTap: () => _pickEnd(),
                ),
            ]),
            _Group(children: [
              _TapRow(
                icon: CupertinoIcons.circle_grid_3x3,
                label: t.calendar,
                value: cals
                        .cast<Calendar?>()
                        .firstWhere((c) => c?.id == d.calendarId, orElse: () => null)
                        ?.title ??
                    '—',
                onTap: () => _pickCalendar(cals),
              ),
              _ColorRow(
                colorId: d.colorId,
                onChanged: (c) => setState(() => d.colorId = c),
              ),
            ]),
            _Group(children: [
              _TapRow(
                icon: CupertinoIcons.repeat,
                label: t.repeat,
                value: _repeatLabel(t, d.recurrence.freq),
                onTap: () => _pickRepeat(),
              ),
              _TapRow(
                icon: CupertinoIcons.bell,
                label: t.alert,
                value: _alertLabel(t, d.alertMinutes),
                onTap: () => _pickAlert(),
              ),
            ]),
            _Group(children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: CupertinoTextField(
                  controller: _notes,
                  placeholder: t.notes,
                  decoration: null,
                  maxLines: 4,
                  minLines: 2,
                ),
              ),
            ]),
            if (_isEditing)
              Padding(
                padding: const EdgeInsets.fromLTRB(Tokens.gutter, 16, Tokens.gutter, 8),
                child: CupertinoButton(
                  color: CupertinoColors.systemGrey6.resolveFrom(context),
                  borderRadius: BorderRadius.circular(Tokens.rButton),
                  onPressed: _delete,
                  child: Text(t.deleteEvent,
                      style: TextStyle(color: CupertinoColors.systemRed.resolveFrom(context))),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- pickers ---
  Future<void> _pickStart() async {
    final picked = await _pickDateTime(context, d.start, dateOnly: d.allDay, use24h: ref.read(use24hProvider));
    if (picked != null) {
      setState(() {
        final delta = picked.difference(d.start);
        d.start = picked;
        d.end = d.end.add(delta); // keep duration
      });
    }
  }

  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(context, d.end, dateOnly: d.allDay, use24h: ref.read(use24hProvider));
    if (picked != null) setState(() => d.end = picked);
  }

  Future<void> _pickCalendar(List<Calendar> cals) async {
    final t = AppLocalizations.of(context);
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: Text(t.calendar),
        actions: cals
            .map((cal) => CupertinoActionSheetAction(
                  onPressed: () {
                    setState(() => d.calendarId = cal.id);
                    Navigator.pop(c);
                  },
                  child: Text(cal.title),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: Text(t.cancel)),
      ),
    );
  }

  Future<void> _pickRepeat() async {
    final t = AppLocalizations.of(context);
    final options = {
      Freq.none: t.repeatNever,
      Freq.daily: t.repeatDaily,
      Freq.weekly: t.repeatWeekly,
      Freq.monthly: t.repeatMonthly,
      Freq.yearly: t.repeatYearly,
    };
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: Text(t.repeat),
        actions: options.entries
            .map((e) => CupertinoActionSheetAction(
                  onPressed: () {
                    setState(() => d.recurrence = d.recurrence.copyWith(freq: e.key));
                    Navigator.pop(c);
                  },
                  child: Text(e.value),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: Text(t.cancel)),
      ),
    );
  }

  Future<void> _pickAlert() async {
    final t = AppLocalizations.of(context);
    const values = <int?>[null, 0, 5, 10, 15, 30, 60];
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: Text(t.alert),
        actions: values
            .map((m) => CupertinoActionSheetAction(
                  onPressed: () {
                    setState(() => d.alertMinutes = m);
                    Navigator.pop(c);
                  },
                  child: Text(_alertLabel(t, m)),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: Text(t.cancel)),
      ),
    );
  }

  String _fmt(DateTime dt, bool allDay, bool use24h) =>
      allDay ? fmtDate(dt) : fmtDateTime(dt, use24h);

  String _repeatLabel(AppLocalizations t, Freq f) => {
        Freq.none: t.repeatNever,
        Freq.daily: t.repeatDaily,
        Freq.weekly: t.repeatWeekly,
        Freq.monthly: t.repeatMonthly,
        Freq.yearly: t.repeatYearly,
      }[f]!;

  String _alertLabel(AppLocalizations t, int? m) {
    if (m == null) return t.alertNone;
    if (m == 0) return t.atTimeOfEvent;
    if (m % 60 == 0) return t.hoursBefore(m ~/ 60);
    return t.minutesBefore(m);
  }
}

Future<DateTime?> _pickDateTime(BuildContext context, DateTime initial,
    {bool dateOnly = false, bool use24h = true}) {
  DateTime temp = initial;
  return showCupertinoModalPopup<DateTime>(
    context: context,
    builder: (context) => Container(
      height: 320,
      color: CupertinoColors.systemBackground.resolveFrom(context),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SizedBox(
              height: 44,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CupertinoButton(
                    onPressed: () => Navigator.pop(context, temp),
                    child: Text(AppLocalizations.of(context).done, style: const TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoDatePicker(
                initialDateTime: initial,
                mode: dateOnly
                    ? CupertinoDatePickerMode.date
                    : CupertinoDatePickerMode.dateAndTime,
                use24hFormat: use24h,
                onDateTimeChanged: (v) => temp = v,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// --- small building blocks ---

class _Group extends StatelessWidget {
  final List<Widget> children;
  const _Group({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(Tokens.gutter, 8, Tokens.gutter, 0),
      decoration: BoxDecoration(
        color: CupertinoColors.secondarySystemGroupedBackground.resolveFrom(context),
        borderRadius: BorderRadius.circular(Tokens.rButton),
      ),
      child: Column(children: children),
    );
  }
}

class _TapRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  final VoidCallback onTap;
  const _TapRow({required this.icon, required this.label, required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        constraints: const BoxConstraints(minHeight: Tokens.minTap),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: icon == null
                  ? null
                  : Icon(icon, size: 18, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
            ),
            Text(label, style: AppText.pill(context)),
            const Spacer(),
            Flexible(
              child: Text(value,
                  textAlign: TextAlign.right,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.secondary(context)),
            ),
            const SizedBox(width: 4),
            Icon(CupertinoIcons.chevron_right,
                size: 14, color: CupertinoColors.tertiaryLabel.resolveFrom(context)),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _ToggleRow(
      {required this.icon, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: Tokens.minTap),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Icon(icon, size: 18, color: CupertinoColors.secondaryLabel.resolveFrom(context)),
          ),
          Text(label, style: AppText.pill(context)),
          const Spacer(),
          CupertinoSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}

class _ColorRow extends StatelessWidget {
  final int? colorId;
  final ValueChanged<int?> onChanged;
  const _ColorRow({required this.colorId, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 28,
                child: Icon(CupertinoIcons.paintbrush,
                    size: 18,
                    color: CupertinoColors.secondaryLabel.resolveFrom(context)),
              ),
              Text(AppLocalizations.of(context).color, style: AppText.pill(context)),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: List.generate(EventColors.palette.length, (i) {
              final selected = colorId == i;
              return GestureDetector(
                onTap: () => onChanged(i),
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color: EventColors.palette[i],
                    shape: BoxShape.circle,
                    border: selected
                        ? Border.all(
                            color: CupertinoColors.label.resolveFrom(context), width: 2)
                        : null,
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
