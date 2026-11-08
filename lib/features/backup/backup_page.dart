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
    showCupertinoDialog<void>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: const Text('Backup copied'),
        content: Text(
            'Your data (${json.length} chars) is on the clipboard. Paste it '
            'somewhere safe, or into "Restore" on another device.'),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(c),
              child: const Text('OK')),
        ],
      ),
    );
  }

  Future<void> _restore() async {
    final text = _import.text.trim();
    if (text.isEmpty) return;
    final ok = await showCupertinoDialog<bool>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: const Text('Restore backup?'),
        content: const Text('This replaces all current calendars and events.'),
        actions: [
          CupertinoDialogAction(
              onPressed: () => Navigator.pop(c, false), child: const Text('Cancel')),
          CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () => Navigator.pop(c, true),
              child: const Text('Restore')),
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
      error = 'Could not restore this backup.';
    }
    if (!mounted) return;
    _import.clear();
    showCupertinoDialog<void>(
      context: context,
      builder: (c) => CupertinoAlertDialog(
        title: Text(error == null ? 'Restored' : 'Restore failed'),
        content: Text(error ?? 'Your data was restored from the backup.'),
        actions: [
          CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () => Navigator.pop(c),
              child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: const CupertinoNavigationBar(middle: Text('Backup & restore')),
      child: SafeArea(
        child: ListView(
          children: [
            CupertinoListSection.insetGrouped(
              header: const Text('Backup'),
              footer: const Text(
                  'Copies all your calendars, events and settings as JSON to the '
                  'clipboard. Keep it safe or paste it into Restore on another device.'),
              children: [
                CupertinoListTile(
                  title: const Text('Export to clipboard'),
                  leading: const Icon(CupertinoIcons.square_arrow_up),
                  trailing: const CupertinoListTileChevron(),
                  onTap: _export,
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('Restore'),
              footer: const Text('Paste a Cally backup and restore it. '
                  'This replaces everything currently in the app.'),
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: CupertinoTextField(
                    controller: _import,
                    placeholder: 'Paste backup JSON here',
                    maxLines: 6,
                    minLines: 4,
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
                CupertinoListTile(
                  title: const Text('Restore from pasted backup'),
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
