import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/time/formats.dart';
import '../month/month_providers.dart';

/// "Restore events": events deleted recently, with restore / restore all /
/// delete all. Fully local (the deleted-events cache table).
class RestorePage extends ConsumerWidget {
  const RestorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deleted = ref.watch(deletedEventsProvider).value ?? const [];
    final repo = ref.read(repositoryProvider);
    final use24h = ref.watch(use24hProvider);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Restore events'),
        trailing: deleted.isEmpty
            ? null
            : CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => _menu(context, repo),
                child: const Icon(CupertinoIcons.ellipsis_circle),
              ),
      ),
      child: SafeArea(
        child: deleted.isEmpty
            ? Center(
                child: Text('Nothing to restore',
                    style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
              )
            : ListView(
                children: [
                  CupertinoListSection.insetGrouped(
                    children: [
                      for (final d in deleted)
                        CupertinoListTile(
                          title: Text(d.title),
                          subtitle: Text(
                              d.allDay ? fmtDate(d.start) : fmtDateTime(d.start, use24h)),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => repo.restore(d.id),
                            child: const Text('Restore'),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _menu(BuildContext context, repo) async {
    final action = await showCupertinoModalPopup<String>(
      context: context,
      builder: (c) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
              onPressed: () => Navigator.pop(c, 'all'), child: const Text('Restore all')),
          CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(c, 'clear'),
              child: const Text('Delete all permanently')),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
      ),
    );
    if (action == 'all') await repo.restoreAll();
    if (action == 'clear') await repo.clearDeleted();
  }
}
