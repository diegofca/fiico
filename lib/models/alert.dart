// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class FiicoAlert {
  final bool? active;
  final Timestamp? date;
  final String? type;

  FiicoAlert({this.active, this.date, this.type});

  FiicoAlert.empty({
    this.active = false,
    this.type = FiicoAlert.SIMPLE_TYPE,
    this.date,
  });

  factory FiicoAlert.fromJson(Map<String, dynamic>? json) {
    return FiicoAlert(
      active: json?['active'],
      date: json?['date'],
      type: json?['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'date': date,
      'type': type,
    };
  }

  static const SIMPLE_TYPE = 'SIMPLE';
  static const INTENSIVE_TYPE = 'INTENSIVE';

  bool isIntensive() {
    return type == FiicoAlert.INTENSIVE_TYPE;
  }
}
