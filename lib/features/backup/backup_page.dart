import '../../l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import '../../data/backup_repository.dart';
import '../month/month_providers.dart';

/// Backup & restore: export the whole local store as a JSON document, and
/// restore it on another device (the data layer for cross-device sync; the
/// cloud transport comes later).
class BackupPage extends ConsumerStatefulWidget {
  const BackupPage({super.key});

  @override
  ConsumerState<BackupPage> createState() => _BackupPageState();
}

class _BackupPageState extends ConsumerState<BackupPage> {
  final _import = TextEditingController();

  @override
  void dispose() {
    _import.dispose();
    super.dispose();
  }

  Future<void> _export() async {
    final json = await ref.read(backupRepositoryProvider).exportJson();
    await Clipboard.setData(ClipboardData(text: json));
    if (!mounted) return;
    final t = AppLocalizations.of(context);
    showCupertinoDialog<void>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(t.backupCopied),
        content: Text(t.backupCopiedMsg(json.length)),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(c),
              child: Text(t.ok)),
        ],
      ),
    );
  }

  Future<void> _restore() async {
    final text = _import.text.trim();
    if (text.isEmpty) return;
    final t = AppLocalizations.of(context);
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(t.restoreBackupQ),
        content: Text(t.restoreReplaceWarning),
        actions: [
          CupertinoDialogAction(
              onPressed: () => Navigator.pop(c, false), child: Text(t.cancel)),
          CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(c, true),
              child: Text(t.restore)),
        ],
      ),
    );
    if (ok != true) return;
    String? error;
    try {
      await ref.read(backupRepositoryProvider).importJson(text);
    } on BackupFormatException catch (e) {
      error = e.message;
    } catch (_) {
      error = t.restoreFailed;
    }
    if (!mounted) return;
    _import.clear();
    showCupertinoDialog<void>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(error == null ? t.restored : t.restoreFailed),
        content: Text(error ?? t.restoredMsg),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(c),
              child: Text(t.ok)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: CupertinoNavigationBar(middle: Text(t.backupRestore)),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: Text(t.backup),
              footer: Text(t.backupFooter),
              children: [
                CupertinoListTile(
                  title: Text(t.exportToClipboard),
                  leading: const Icon(CupertinoIcons.square_arrow_up),
                  trailing: const CupertinoListTileChevron(),
                  onTap: _export,
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: Text(t.restoreTitle),
              footer: Text(t.restoreFooter),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoTextField(
                    controller: _import,
                    placeholder: t.pasteBackupHere,
                    maxLines: 6,
                    minLines: 4,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
                CupertinoListTile(
                  title: Text(t.restoreFromPasted),
                  leading: const Icon(CupertinoIcons.square_arrow_down),
                  onTap: _restore,
                ),
              ],
            ),
            const SizedBox(height: Tokens.gutter),
          ],
        ),
      ),
    );
  }
}
