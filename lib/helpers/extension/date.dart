import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDateString(String format) {
    return DateFormat(
      format,
      FiicoLocale.locale.toString(),
    ).format(this);
  }

  /// Format "MMM, dd yyyy"
  String toDateFormat1() {
    return DateFormat(
      "MMM, dd yyyy",
      FiicoLocale.locale.toString(),
    ).format(this);
  }

  /// Format "EEEE MMM, dd yyyy"
  String toDateFormat2() {
    return DateFormat(
      "EEEE, dd MMM yyyy",
      FiicoLocale.locale.toString(),
    ).format(this);
  }

  /// Format "EE MMM, dd yyyy"
  String toDateFormat3() {
    return DateFormat(
      "EE - MMM dd, yyyy",
      FiicoLocale.locale.toString(),
    ).format(this);
  }

  /// Format "MMM, dd yyyy"
  String toDateFormat4() {
    return DateFormat(
      "MMMM dd, yyyy",
      FiicoLocale.locale.toString(),
    ).format(this);
  }

  /// Format "MMM, dd yyyy"
  String toMonthAndYear() {
    return DateFormat(
      "MMMM, yyyy",
      FiicoLocale.locale.toString(),
    ).format(this);
  }

  String toDateFormat5() {
    return DateFormat(
      "MMM dd - yyy",
      FiicoLocale.locale.toString(),
    ).format(this);
  }
}
