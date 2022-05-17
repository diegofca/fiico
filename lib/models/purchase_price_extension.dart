import 'dart:io';

import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';

class FiicoProductWrapper {
  static String getPrice(ProductDetails detail) {
    if (Platform.isIOS) {
      if (detail is AppStoreProductDetails) {
        SKProductWrapper skProduct = detail.skProduct;
        return '${skProduct.priceLocale.currencySymbol}${skProduct.price} ${skProduct.priceLocale.currencyCode}';
      }
    }
    if (detail is GooglePlayProductDetails) {
      SkuDetailsWrapper skProduct = detail.skuDetails;
      return '${skProduct.priceCurrencySymbol}${skProduct.price} ${skProduct.priceCurrencyCode}';
    }
    return '';
  }
}