// ignore_for_file: constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';

class MarkMovement {
  final Timestamp? date;
  final String? userName;

  MarkMovement({this.date, this.userName});

  factory MarkMovement.fromJson(Map<String, dynamic>? json) {
    return MarkMovement(
      date: json?['date'],
      userName: json?['userName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'userName': userName,
    };
  }

  static List<MarkMovement> toList(Map<String, dynamic>? json) {
    List<MarkMovement> marks = [];
    json?['markHistory']?.forEach((move) {
      marks.add(MarkMovement.fromJson(move));
    });
    return marks;
  }
}
