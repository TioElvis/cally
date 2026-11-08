import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/tokens.dart';
import '../../core/time/formats.dart';
import '../../core/time/month_grid.dart';
import '../../data/models.dart';
import '../event_editor/event_editor_sheet.dart';
import '../notifications/notification_providers.dart';
import '../widgets/deep_link.dart';
import '../widgets/widget_providers.dart';
import '../search/search_sheet.dart';
import '../share/event_share.dart';
import '../share/share_providers.dart';
import '../settings/settings_page.dart';
import 'month_grid_view.dart';
import 'month_providers.dart';

/// The home screen: a big month header, weekday row, an interruptible pager of
/// month grids, and the selected-day agenda below.
class MonthPage extends ConsumerStatefulWidget {
  const MonthPage({super.key});

  @override
  ConsumerState<MonthPage> createState() => _MonthPageState();
}

class _MonthPageState extends ConsumerState<MonthPage> {
  static const _initialPage = 1200; // ~100 years of headroom either way
  late final DateTime _baseMonth;
  late final PageController _controller;
  StreamSubscription<Uri?>? _tapSub;

  @override
  void initState() {
    super.initState();
    _baseMonth = firstOfMonth(DateTime.now());
    _controller = PageController(initialPage: _initialPage);
    _wireWidgetLinks();
  }

  Future<void> _wireWidgetLinks() async {
    final bridge = ref.read(homeWidgetBridgeProvider);
    final initial = await bridge.initialLaunch();
    if (initial != null && mounted) _handleAction(parseDeepLink(initial));
    _tapSub = bridge.taps().listen((uri) {
      if (mounted) _handleAction(parseDeepLink(uri));
    });
  }

  void _handleAction(WidgetAction action) {
    switch (action) {
      case OpenToday():
        _goToToday();
      case OpenDay(:final day):
        _selectDay(day);
      case NewEvent(:final day):
        final DateTime target = day ?? ref.read(selectedDayProvider);
        _selectDay(target);
        final cal = ref.read(defaultCalendarProvider);
        if (cal != null) showEventEditor(context, EventDraft.newAt(target, cal.id));
    }
  }

  @override
  void dispose() {
    _tapSub?.cancel();
    _controller.dispose();
    super.dispose();
  }

  DateTime _monthForPage(int page) => addMonths(_baseMonth, page - _initialPage);
  int _pageForMonth(DateTime m) => _initialPage + monthsBetween(m, _baseMonth);

  void _onPageChanged(int page) {
    ref.read(focusedMonthProvider.notifier).set(_monthForPage(page));
    HapticFeedback.selectionClick();
  }

  void _goToMonth(DateTime month, {required bool animate}) {
    final page = _pageForMonth(month);
    final reduceMotion = MediaQuery.maybeDisableAnimationsOf(context) ?? false;
    if (animate && !reduceMotion) {
      _controller.animateToPage(page, duration: Tokens.base, curve: Tokens.curve);
    } else {
      _controller.jumpToPage(page);
    }
  }

  void _selectDay(DateTime day) {
    ref.read(selectedDayProvider.notifier).set(day);
    HapticFeedback.selectionClick();
    final focused = ref.read(focusedMonthProvider);
    if (!isSameMonth(day, focused)) {
      _goToMonth(firstOfMonth(day), animate: true);
    }
  }

  void _goToToday() {
    final now = DateTime.now();
    ref.read(selectedDayProvider.notifier).set(now);
    HapticFeedback.selectionClick();
    _goToMonth(firstOfMonth(now), animate: true);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(seedProvider); // create defaults + samples on first run
    ref.watch(notificationSchedulerProvider); // keep alarms + badge in sync
    ref.watch(widgetRefresherProvider); // keep home widgets in sync
    final focused = ref.watch(focusedMonthProvider);
    final selected = ref.watch(selectedDayProvider);
    final isCurrentMonth = isSameMonth(focused, DateTime.now());

    return CupertinoPageScaffold(
      child: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Header(
              month: focused,
              showToday: !isCurrentMonth || !isSameDay(selected, dateOnly(DateTime.now())),
              onToday: _goToToday,
            ),
            const _WeekdayRow(),
            SizedBox(
              height: Tokens.rowHeight * Tokens.gridRows,
              child: PageView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(),
                onPageChanged: _onPageChanged,
                itemBuilder: (context, page) => MonthGridView(
                  monthAnchor: _monthForPage(page),
                  onSelectDay: _selectDay,
                ),
              ),
            ),
            Expanded(child: _DayAgenda(day: selected)),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final DateTime month;
  final bool showToday;
  final VoidCallback onToday;

  const _Header({required this.month, required this.showToday, required this.onToday});

  @override
  Widget build(BuildContext context) {
    final label = DateFormat('MMM').format(month).toUpperCase();
    return Padding(
      padding: const EdgeInsets.fromLTRB(Tokens.gutter, 8, Tokens.gutter, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Semantics(
              header: true,
              label: DateFormat('MMMM y').format(month),
              child: Text(label, style: AppText.monthHeader(context)),
            ),
          ),
          if (showToday) _TodayPill(onPressed: onToday),
          _HeaderIcon(
            icon: CupertinoIcons.search,
            semanticLabel: 'Search',
            onPressed: () => showSearch(context),
          ),
          _HeaderIcon(
            icon: CupertinoIcons.gear,
            semanticLabel: 'Settings',
            onPressed: () => Navigator.of(context)
                .push(CupertinoPageRoute(builder: (_) => const SettingsPage())),
          ),
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  final IconData icon;
  final String semanticLabel;
  final VoidCallback onPressed;
  const _HeaderIcon(
      {required this.icon, required this.semanticLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      minimumSize: const Size.square(Tokens.minTap),
      onPressed: onPressed,
      child: Icon(icon, size: 22, color: CupertinoColors.label.resolveFrom(context)),
    );
  }
}

class _TodayPill extends StatelessWidget {
  final VoidCallback onPressed;
  const _TodayPill({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final brand = Tokens.brand.resolveFrom(context);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: const Size.square(Tokens.minTap),
      onPressed: onPressed,
      child: Semantics(
        button: true,
        label: 'Go to today',
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Tokens.rPill),
            border: Border.all(color: brand, width: 1.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(CupertinoIcons.arrow_uturn_left, size: 14, color: brand),
              const SizedBox(width: 5),
              Text('TODAY',
                  style: AppText.weekday(context, color: brand).copyWith(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekdayRow extends ConsumerWidget {
  const _WeekdayRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekStart = ref.watch(weekStartProvider);
    final showWeeks =
        (ref.watch(settingsProvider).value ?? const AppSettings()).weekNumbersEnabled;
    final order = weekdayOrder(weekStart);
    // 2024-01-01 is a Monday (weekday 1); pick a date per weekday for its letter.
    final monday = DateTime(2024, 1, 1);
    return Padding(
      padding: const EdgeInsets.only(
          left: Tokens.gutterEdge, right: Tokens.gutterEdge, top: 2, bottom: 6),
      child: Row(
        children: [
          if (showWeeks) const SizedBox(width: weekColWidth),
          ...order.map((w) {
          final date = monday.add(Duration(days: w - 1));
          final letter = DateFormat('EEEEE').format(date).toUpperCase();
          final isSunday = w == DateTime.sunday;
          return Expanded(
            child: Center(
              child: Text(
                letter,
                style: AppText.weekday(
                  context,
                  color: isSunday ? CupertinoColors.systemRed.resolveFrom(context) : null,
                ),
              ),
            ),
          );
        }),
        ],
      ),
    );
  }
}

class _DayAgenda extends ConsumerWidget {
  final DateTime day;
  const _DayAgenda({required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(dayOccurrencesProvider(day));
    final heading = DateFormat('EEE d MMM y').format(day);

    Future<void> openEditor(DayOccurrence occ) async {
      final rows = ref.read(eventRowsProvider).value ?? const [];
      final matches = rows.where((r) => r.id == occ.masterId);
      if (matches.isNotEmpty) {
        await showEventEditor(context, EventDraft.fromRow(matches.first));
      }
    }

    Future<void> openActions(DayOccurrence occ) async {
      final rows = ref.read(eventRowsProvider).value ?? const [];
      final matches = rows.where((r) => r.id == occ.masterId);
      if (matches.isEmpty) return;
      final row = matches.first;
      final use24h = ref.read(use24hProvider);
      final share = ref.read(shareServiceProvider);
      HapticFeedback.selectionClick();
      final action = await showCupertinoModalPopup<String>(
        context: context,
        builder: (c) => CupertinoActionSheet(
          title: Text(occ.title),
          actions: [
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(c, 'text'), child: const Text('Share as text')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(c, 'ics'),
                child: const Text('Share as calendar file (.ics)')),
            CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(c, 'edit'), child: const Text('Edit')),
            CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () => Navigator.pop(c, 'delete'),
                child: const Text('Delete')),
          ],
          cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
        ),
      );
      switch (action) {
        case 'text':
          await share.shareText(eventToText(occ, use24h,
              location: row.location, notes: row.notes, url: row.url));
        case 'ics':
          await share.shareIcs(eventToIcs(row), '${_icsName(row.title)}.ics');
        case 'edit':
          if (context.mounted) await showEventEditor(context, EventDraft.fromRow(row));
        case 'delete':
          await ref.read(repositoryProvider).delete(row.id);
      }
    }

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CupertinoColors.separator.resolveFrom(context),
            width: 0.5,
          ),
        ),
      ),
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(Tokens.gutter, 14, Tokens.gutter, 8),
            sliver: SliverToBoxAdapter(
              child: Text(heading, style: AppText.dayHeading(context)),
            ),
          ),
          if (events.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(Tokens.gutter, 8, Tokens.gutter, 8),
                child: Text('No events', style: AppText.secondary(context)),
              ),
            )
          else
            SliverList.builder(
              itemCount: events.length,
              itemBuilder: (context, i) => _AgendaRow(
                event: events[i],
                use24h: ref.watch(use24hProvider),
                onTap: () => openEditor(events[i]),
                onLongPress: () => openActions(events[i]),
              ),
            ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(child: _NewEventButton(day: day)),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}

class _AgendaRow extends StatelessWidget {
  final DayOccurrence event;
  final bool use24h;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  const _AgendaRow({
    required this.event,
    required this.use24h,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final bar = EventColors.base(event.colorId);
    final time = event.allDay
        ? 'All-day'
        : '${fmtTime(event.start, use24h)} – ${fmtTime(event.end, use24h)}';
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter, vertical: 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 4,
              height: 36,
              decoration: BoxDecoration(
                color: bar,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: CupertinoColors.label.resolveFrom(context))),
                  const SizedBox(height: 2),
                  Text(time, style: AppText.secondary(context)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NewEventButton extends ConsumerWidget {
  final DateTime day;
  const _NewEventButton({required this.day});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Tokens.gutter),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 14),
        color: CupertinoColors.systemGrey6.resolveFrom(context),
        borderRadius: BorderRadius.circular(Tokens.rButton),
        onPressed: () {
          HapticFeedback.lightImpact();
          final cal = ref.read(defaultCalendarProvider);
          if (cal == null) return;
          showEventEditor(context, EventDraft.newAt(day, cal.id));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.add,
                size: 18, color: CupertinoColors.label.resolveFrom(context)),
            const SizedBox(width: 6),
            Text('New event', style: AppText.pill(context)),
          ],
        ),
      ),
    );
  }
}

/// A safe-ish file name for an exported .ics.
String _icsName(String title) {
  final cleaned = title.trim().replaceAll(RegExp(r'[^A-Za-z0-9 _-]'), '').trim();
  final name = cleaned.isEmpty ? 'event' : cleaned.replaceAll(RegExp(r'\s+'), '_');
  return name.length <= 40 ? name : name.substring(0, 40);
}
