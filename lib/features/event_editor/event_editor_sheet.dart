import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/tokens.dart';
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
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: const Text('Delete event?'),
        content: d.recurrence.repeats
            ? const Text('This deletes the whole repeating series.')
            : null,
        actions: [
          CupertinoDialogAction(
              onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Delete')),
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        middle: Text(_isEditing ? 'Edit' : 'New event'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: _save,
          child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w600)),
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
                placeholder: 'Event name',
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
                label: 'All-day',
                value: d.allDay,
                onChanged: (v) => setState(() => d.allDay = v),
              ),
              _TapRow(
                icon: CupertinoIcons.calendar,
                label: 'Starts',
                value: _fmt(d.start, d.allDay),
                onTap: () => _pickStart(),
              ),
              if (!d.allDay)
                _TapRow(
                  icon: null,
                  label: 'Ends',
                  value: _fmt(d.end, d.allDay),
                  onTap: () => _pickEnd(),
                ),
            ]),
            _Group(children: [
              _TapRow(
                icon: CupertinoIcons.circle_grid_3x3,
                label: 'Calendar',
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
                label: 'Repeat',
                value: _repeatLabel(d.recurrence.freq),
                onTap: () => _pickRepeat(),
              ),
              _TapRow(
                icon: CupertinoIcons.bell,
                label: 'Alert',
                value: _alertLabel(d.alertMinutes),
                onTap: () => _pickAlert(),
              ),
            ]),
            _Group(children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: CupertinoTextField(
                  controller: _notes,
                  placeholder: 'Notes',
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
                  child: Text('Delete event',
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
    final picked = await _pickDateTime(context, d.start, dateOnly: d.allDay);
    if (picked != null) {
      setState(() {
        final delta = picked.difference(d.start);
        d.start = picked;
        d.end = d.end.add(delta); // keep duration
      });
    }
  }

  Future<void> _pickEnd() async {
    final picked = await _pickDateTime(context, d.end, dateOnly: d.allDay);
    if (picked != null) setState(() => d.end = picked);
  }

  Future<void> _pickCalendar(List<Calendar> cals) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: const Text('Calendar'),
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
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
  }

  Future<void> _pickRepeat() async {
    const options = {
      Freq.none: 'Doesn\'t repeat',
      Freq.daily: 'Daily',
      Freq.weekly: 'Weekly',
      Freq.monthly: 'Monthly',
      Freq.yearly: 'Yearly',
    };
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: const Text('Repeat'),
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
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
  }

  Future<void> _pickAlert() async {
    const options = <int?, String>{
      null: 'None',
      0: 'At time of event',
      5: '5 minutes before',
      10: '10 minutes before',
      15: '15 minutes before',
      30: '30 minutes before',
      60: '1 hour before',
    };
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        title: const Text('Alert'),
        actions: options.entries
            .map((e) => CupertinoActionSheetAction(
                  onPressed: () {
                    setState(() => d.alertMinutes = e.key);
                    Navigator.pop(c);
                  },
                  child: Text(e.value),
                ))
            .toList(),
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
  }

  String _fmt(DateTime dt, bool allDay) => allDay
      ? DateFormat('EEE d MMM y').format(dt)
      : DateFormat('EEE d MMM, HH:mm').format(dt);

  String _repeatLabel(Freq f) => const {
        Freq.none: 'Doesn\'t repeat',
        Freq.daily: 'Daily',
        Freq.weekly: 'Weekly',
        Freq.monthly: 'Monthly',
        Freq.yearly: 'Yearly',
      }[f]!;

  String _alertLabel(int? m) {
    if (m == null) return 'None';
    if (m == 0) return 'At time of event';
    if (m == 60) return '1 hour before';
    return '$m minutes before';
  }
}

Future<DateTime?> _pickDateTime(BuildContext context, DateTime initial,
    {bool dateOnly = false}) {
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
                    child: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
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
                use24hFormat: true,
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
              Text('Color', style: AppText.pill(context)),
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
