import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDateString(String format) {
    return DateFormat(format).format(this);
  }

  /// Format "MMM, dd yyyy"
  String toDateFormat1() {
    return DateFormat("MMM, dd yyyy").format(this);
  }

  // DateTime date() {
  //   return DateTime.parse(this);
  // }
}
