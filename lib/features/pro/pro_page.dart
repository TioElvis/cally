import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/tokens.dart';
import 'pro.dart';

/// The Pro paywall. Lists what Pro unlocks and offers a one-time purchase +
/// restore. The purchase is a local fake for now (unlocks on tap); the real
/// one-time StoreKit / Play Billing purchase is wired in M8.
class ProPage extends ConsumerWidget {
  const ProPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPro = ref.watch(isProProvider);
    final purchases = ref.read(purchaseServiceProvider);
    final brand = Tokens.brand.resolveFrom(context);

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground.resolveFrom(context),
      navigationBar: const CupertinoNavigationBar(middle: Text('Cally Pro')),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Tokens.gutter),
          children: [
            const SizedBox(height: 8),
            Icon(CupertinoIcons.star_circle_fill, size: 56, color: brand),
            const SizedBox(height: 12),
            Center(
              child: Text(
                isPro ? 'You have Cally Pro' : 'Unlock Cally Pro',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text(
                'One-time purchase. No ads, ever. No tracking.',
                style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context)),
              ),
            ),
            const SizedBox(height: 20),
            CupertinoListSection.insetGrouped(
              children: [
                for (final f in proFeatures)
                  CupertinoListTile(
                    leading: Icon(CupertinoIcons.check_mark_circled_solid, color: brand),
                    title: Text(f),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (!isPro) ...[
              CupertinoButton.filled(
                onPressed: () async {
                  final ok = await purchases.buyPro();
                  if (ok) HapticFeedback.mediumImpact();
                  if (context.mounted && ok) Navigator.pop(context);
                },
                child: Text('Unlock Pro · ${purchases.priceLabel}'),
              ),
              const SizedBox(height: 8),
              Center(
                child: CupertinoButton(
                  onPressed: () async {
                    final restored = await purchases.restore();
                    if (!context.mounted) return;
                    showCupertinoDialog<void>(
                      context: context,
                      builder: (c) => CupertinoAlertDialog(
                        title: Text(restored ? 'Restored' : 'Nothing to restore'),
                        content: Text(restored
                            ? 'Your Pro purchase was restored.'
                            : 'No previous purchase was found for this account.'),
                        actions: [
                          CupertinoDialogAction(
                              isDefaultAction: true,
                              onPressed: () => Navigator.pop(c),
                              child: const Text('OK')),
                        ],
                      ),
                    );
                  },
                  child: const Text('Restore purchases'),
                ),
              ),
            ] else
              Center(
                child: Text('Thanks for supporting Cally 💜',
                    style: TextStyle(color: CupertinoColors.secondaryLabel.resolveFrom(context))),
              ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Pricing is a placeholder until store setup (M8).',
                style: TextStyle(
                    fontSize: 12, color: CupertinoColors.tertiaryLabel.resolveFrom(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
