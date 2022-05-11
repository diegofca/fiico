import 'package:intl/intl.dart';

extension NumExtension on num {
  String toCurrency() {
    String value = NumberFormat.currency(
      customPattern: '###,###.##',
    ).format(
      this,
    );
    return "\$$value";
  }

  String toExactlyCurrency() {
    String value = NumberFormat.currency(
      customPattern: '###,###',
      decimalDigits: 0,
    ).format(
      this,
    );
    return value;
  }

  String toCurrencyCompat() {
    String value = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '\$ ',
    ).format(
      this,
    );
    return value;
  }
}
