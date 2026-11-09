import 'dart:async';

import 'package:in_app_purchase/in_app_purchase.dart';

import '../../data/settings_repository.dart';
import 'pro.dart';

/// Real one-time Pro purchase over StoreKit / Play Billing. This is wired but
/// unverified until the store products exist (App Store Connect / Play Console
/// non-consumable with id [productId]) — see docs/INTEGRATIONS.md. Until then
/// the app uses [FakePurchaseService]; swap `purchaseServiceProvider` to this
/// once products are live.
class StorePurchaseService implements PurchaseService {
  static const productId = 'cally_pro';

  final SettingsRepository settings;
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _sub;
  ProductDetails? _product;

  StorePurchaseService(this.settings) {
    _sub = _iap.purchaseStream.listen(_onPurchases, onError: (_) {});
  }

  void dispose() => _sub?.cancel();

  @override
  String get priceLabel => _product?.price ?? '—';

  Future<void> loadProduct() async {
    if (!await _iap.isAvailable()) return;
    final resp = await _iap.queryProductDetails({productId});
    if (resp.productDetails.isNotEmpty) _product = resp.productDetails.first;
  }

  @override
  Future<bool> buyPro() async {
    await loadProduct();
    final product = _product;
    if (product == null) return false; // product not configured yet
    // The entitlement is granted in _onPurchases when the store confirms.
    return _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: product));
  }

  @override
  Future<bool> restore() async {
    await _iap.restorePurchases();
    return true; // results arrive on the stream
  }

  Future<void> _onPurchases(List<PurchaseDetails> purchases) async {
    for (final p in purchases) {
      if (p.productID != productId) continue;
      if (p.status == PurchaseStatus.purchased || p.status == PurchaseStatus.restored) {
        await settings.setPro(true);
      }
      if (p.pendingCompletePurchase) {
        await _iap.completePurchase(p);
      }
    }
  }
}
