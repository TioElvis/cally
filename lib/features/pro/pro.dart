import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/settings_repository.dart';
import '../month/month_providers.dart';

/// What Pro unlocks (shown on the paywall). Cosmetic + power features; the app's
/// core (sync-ready store, editor, search, notifications, widgets, sharing) is free.
const proFeatures = <String>[
  'Week numbers in the month grid',
  'More color themes (coming soon)',
  'Copy an event to multiple dates (coming soon)',
  'Support a privacy-first, ad-free calendar',
];

/// Purchase handling. Local fake for now (unlocks on tap for dev); the real
/// one-time StoreKit / Play Billing purchase is wired in the integrations
/// milestone (M8). The entitlement (`isPro`) is stored locally either way.
abstract class PurchaseService {
  String get priceLabel;
  Future<bool> buyPro();
  Future<bool> restore();
}

class FakePurchaseService implements PurchaseService {
  final SettingsRepository settings;
  final bool Function() currentlyPro;
  FakePurchaseService(this.settings, this.currentlyPro);

  @override
  String get priceLabel => '€9.99'; // placeholder until store pricing (M8)

  @override
  Future<bool> buyPro() async {
    await settings.setPro(true);
    return true;
  }

  @override
  Future<bool> restore() async => currentlyPro();
}

final isProProvider =
    Provider<bool>((ref) => ref.watch(settingsProvider).value?.isPro ?? false);

final purchaseServiceProvider = Provider<PurchaseService>((ref) =>
    FakePurchaseService(
        ref.watch(settingsRepositoryProvider), () => ref.read(isProProvider)));
