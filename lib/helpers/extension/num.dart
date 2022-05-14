import 'dart:ui';

import 'package:intl/intl.dart';

extension NumExtension on num {
  String toCurrency() {
    String value = NumberFormat.currency(
      locale: const Locale('en', 'US').toString(),
      customPattern: '###,###.##',
    ).format(
      this,
    );
    return "\$$value";
  }

  String toExactlyCurrency() {
    String value = NumberFormat.currency(
      locale: const Locale('en', 'US').toString(),
      customPattern: '###,###',
      decimalDigits: 0,
    ).format(
      this,
    );
    return value;
  }

  String toCurrencyCompat() {
    String value = NumberFormat.compactCurrency(
      locale: const Locale('en', 'US').toString(),
      decimalDigits: 1,
      symbol: '\$ ',
    ).format(
      this,
    );
    return value;
  }
}
