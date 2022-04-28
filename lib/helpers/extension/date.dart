import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDateString(String format) {
    return DateFormat(format).format(this);
  }

  /// Format "MMM, dd yyyy"
  String toDateFormat1() {
    return DateFormat("MMM, dd yyyy").format(this);
  }

  /// Format "EEEE MMM, dd yyyy"
  String toDateFormat2() {
    return DateFormat("EEEE, dd MMM yyyy").format(this);
  }

  /// Format "EE MMM, dd yyyy"
  String toDateFormat3() {
    return DateFormat("EE - MMM dd, yyyy").format(this);
  }

  /// Format "MMM, dd yyyy"
  String toDateFormat4() {
    return DateFormat("MMMM dd, yyyy").format(this);
  }
}
