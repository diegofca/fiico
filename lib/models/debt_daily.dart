import 'package:cloud_firestore/cloud_firestore.dart';

class DebtDaily {
  final num value;
  final String? name;
  final String? userName;
  final Timestamp? createdAt;

  DebtDaily({
    required this.value,
    required this.name,
    required this.userName,
    required this.createdAt,
  });

  factory DebtDaily.fromJson(Map<String, dynamic>? json) {
    return DebtDaily(
      value: json?['value'] ?? 0,
      name: json?['name'] ?? '',
      userName: json?['userName'] ?? '',
      createdAt: json?['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'name': name,
      'userName': userName,
      'createdAt': createdAt ?? Timestamp.now(),
    };
  }

  static List<DebtDaily> toList(Map<String, dynamic>? json) {
    List<DebtDaily> debts = [];
    json?['debtDailyList']?.forEach((debt) {
      debts.add(DebtDaily.fromJson(debt));
    });
    return debts;
  }
}
