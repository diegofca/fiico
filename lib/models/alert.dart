// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FiicoAlert {
  final bool? active;
  final List<int>? days;
  final String? type;
  final List<DateTime>? dates;

  FiicoAlert({this.active, this.days, this.type, this.dates});

  FiicoAlert.empty({
    this.active = false,
    this.type = FiicoAlert.SIMPLE_TYPE,
    this.days,
    this.dates,
  });

  factory FiicoAlert.fromJson(Map<String, dynamic>? json) {
    return FiicoAlert(
      active: json?['active'],
      type: json?['type'],
      days: FiicoAlert.toDaysList(json),
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

  static List<int>? toDaysList(Map<String, dynamic>? json) {
    List<int> days = [];
    final jDays = json?['days'] ?? [];
    jDays.forEach((day) {
      days.add(day);
    });
    return days;
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'days': days,
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
