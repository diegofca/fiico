import 'package:cloud_firestore/cloud_firestore.dart';

class Plan {
  final int id;
  final String? name;
  final String? icon;
  Timestamp? startDate = Timestamp.now();

  Plan({
    required this.id,
    required this.name,
    required this.icon,
    this.startDate,
  });

  Plan.free({
    this.id = 0,
    this.name = 'Free',
    this.icon = 'material_design_icons_flutter',
  });

  factory Plan.fromJson(Map<String, dynamic>? json) {
    return Plan(
      id: json?['id'] ?? 0,
      name: json?['name'] ?? '',
      icon: json?['icon'] ?? '',
      startDate: _getStartDate(json?['startDate']),
    );
  }

  static Timestamp _getStartDate(dynamic date) {
    if (date is String) {
      return Timestamp.fromDate(DateTime.parse(date));
    }
    return date ?? Timestamp.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate?.toDate().toIso8601String(),
      'name': name,
      'icon': icon,
    };
  }
}
