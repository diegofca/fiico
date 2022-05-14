// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FiicoAlert {
  final bool? active;
  final int? day;
  final String? type;
  final List<DateTime>? dates;

  FiicoAlert({this.active, this.day, this.type, this.dates});

  FiicoAlert.empty({
    this.active = false,
    this.type = FiicoAlert.SIMPLE_TYPE,
    this.day,
    this.dates,
  });

  factory FiicoAlert.fromJson(Map<String, dynamic>? json) {
    return FiicoAlert(
      active: json?['active'],
      day: json?['day'],
      type: json?['type'],
      dates: FiicoAlert.toDatesList(json),
    );
  }

  static List<DateTime>? toDatesList(Map<String, dynamic>? json) {
    List<DateTime> dates = [];
    final jDates = json?['dates'] ?? [];
    jDates.forEach((date) {
      dates.add((date as Timestamp).toDate());
    });
    return dates;
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'day': day,
      'type': type,
      'dates': dates,
    };
  }

  static const SIMPLE_TYPE = 'SIMPLE';
  static const INTENSIVE_TYPE = 'INTENSIVE';

  bool isIntensive() {
    return type == FiicoAlert.INTENSIVE_TYPE;
  }
}
