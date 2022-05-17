// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:io';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/toast.dart';
import 'package:control/models/plan.dart';
import 'package:control/models/purchase_price_extension.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

class PurchaseManager {
  static PurchaseManager get = PurchaseManager();

  late BuildContext context;

  final InAppPurchase inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];

  final List<String> _kProductIds = <String>[
    'valiu_premium_unlimited',
    'valiu_premium_gold',
    'valiu_premium_diamond'
  ];

  /// ---> Compras predefinidas -------------------------------------------------

  Future<void> purchase(BuildContext context, Plan plan) async {
    this.context = context;
    final user = await Preferences.get.getUser();
    final params = PurchaseParam(
      applicationUserName: user?.userName,
      productDetails: _products.firstWhere((e) => e.id == plan.id),
    );
    inAppPurchase.buyConsumable(purchaseParam: params);
  }

  /// --------------------------------------------------------------------------

  Future<void> _initStoreInfo() async {
    final bool isAvailable = await inAppPurchase.isAvailable();
    if (!isAvailable) {
      _products = [];
      return;
    }

    _finishiOSTransactions();
    final ProductDetailsResponse productDetailResponse =
        await inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error == null) {
      _products = productDetailResponse.productDetails;
    }
  }

  void configureStore() async {
    _subscription = inAppPurchase.purchaseStream.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscription.cancel();
    }, onError: (error) {
      handleError(error);
    });
    await _initStoreInfo();
  }

  List<Plan> getPlans() {
    return _products.map((detail) {
      String price = FiicoProductWrapper.getPrice(detail);
      return Plan.getPlanByID(detail.id)..addPrice(price);
    }).toList();
  }

  bool _verifyPurchase(PurchaseDetails purchaseDetails) {
    return purchaseDetails.status == PurchaseStatus.purchased ||
        purchaseDetails.status == PurchaseStatus.restored;
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      switch (purchaseDetails.status) {
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          handleSuccess(purchaseDetails);
          break;
        case PurchaseStatus.error:
          handleError(purchaseDetails.error);
          break;
        case PurchaseStatus.canceled:
          handleCanceled();
          break;
        case PurchaseStatus.pending:
          handlePending(purchaseDetails);
          break;
        default:
      }
    });
  }

  /// Handlers Response ->   ---------------------------------------------------

  /// PAGO EN ESPERA.
  void handlePending(PurchaseDetails purchaseDetails) async {
    FiicoRoute.showLoader(context);
  }

  /// PAGO CORRECTO.
  void handleSuccess(PurchaseDetails purchaseDetails) async {
    bool valid = _verifyPurchase(purchaseDetails);
    if (valid && purchaseDetails.pendingCompletePurchase) {
      await inAppPurchase.completePurchase(purchaseDetails);

      final productPurchased = Plan.getPlanByID(purchaseDetails.productID);
      FiicoRoute.hideLoader(context);
      FiicoToast.showInfoToast("Compra Correcta!!");

      if (Platform.isAndroid) {
        final InAppPurchaseAndroidPlatformAddition androidAddition =
            inAppPurchase
                .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
        await androidAddition.consumePurchase(purchaseDetails);
      }
    } else {
      _handleInvalidPurchase(purchaseDetails);
    }
  }

  /// PAGO ERRONEO.
  void handleError(IAPError? error) async {
    _finishiOSTransactions();
  }

  /// PAGO CANCELADO.
  void handleCanceled() {
    FiicoToast.showInfoToast("Compra cancelada");
    FiicoRoute.hideLoader(context);
    _finishiOSTransactions();
  }

  /// PAGO INVALIDO.
  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    FiicoToast.showInfoToast("Compra invalida");
    FiicoRoute.hideLoader(context);
    _finishiOSTransactions();
  }

  /// --------------------------------------------------------------------------

  void _finishiOSTransactions() async {
    if (Platform.isIOS) {
      var transactions = await SKPaymentQueueWrapper().transactions();
      for (var skPaymentTransactionWrapper in transactions) {
        SKPaymentQueueWrapper().finishTransaction(skPaymentTransactionWrapper);
      }
    }
  }

  Future<void> confirmPriceChange() async {
    // if (Platform.isAndroid) {
    //   final InAppPurchaseAndroidPlatformAddition androidAddition = inAppPurchase
    //       .getPlatformAddition<InAppPurchaseAndroidPlatformAddition>();
    //   var priceChangeConfirmationResult =
    //       await androidAddition.launchPriceChangeConfirmationFlow(
    //     sku: 'purchaseId',
    //   );
    //   if (priceChangeConfirmationResult.responseCode == BillingResponse.ok) {
    //     print('Price change accepted');
    //   } else {
    //     print(
    //       priceChangeConfirmationResult.debugMessage ??
    //           "Price change failed with code ${priceChangeConfirmationResult.responseCode}",
    //     );
    //   }
    // }
  }
}