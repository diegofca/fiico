// ignore_for_file: constant_identifier_names
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';

enum MovementType { ENTRY, DEBT, SAFE }

class Movement {
  final int id;
  final String name;
  final num value;
  final Timestamp createdAt;
  final String image;
  final String type;
  final String description;
  final String typeDescription;

  final String currency;
  final String budgetName;
  final List<dynamic> tags;

  Movement({
    required this.id,
    required this.name,
    required this.value,
    required this.createdAt,
    required this.image,
    required this.type,
    required this.description,
    required this.typeDescription,
    required this.currency,
    required this.budgetName,
    required this.tags,
  });

  factory Movement.fromJson(Map<String, dynamic>? json) {
    return Movement(
      id: json?['id'],
      name: json?['name'] ?? '',
      value: json?['value'] ?? 0,
      createdAt: json?['createdAt'] ?? Timestamp.now(),
      image: json?['image'] ?? '',
      type: json?['type'] ?? '',
      description: json?['description'] ?? '',
      typeDescription: json?['typeDescription'] ?? '',
      currency: json?['currency'] ?? '',
      budgetName: json?['budgetName'] ?? '',
      tags: json?['tags'] ?? [],
    );
  }

  MovementType getType() {
    switch (type) {
      case 'ENTRY':
        return MovementType.ENTRY;
      case 'DEBT':
        return MovementType.DEBT;
      default:
        return MovementType.SAFE;
    }
  }

  Color getTypeColor() {
    switch (getType()) {
      case MovementType.ENTRY:
        return FiicoColors.greenNeutral;
      case MovementType.DEBT:
        return FiicoColors.pinkRed;
      default:
        return FiicoColors.grayDark;
    }
  }

  static List<Movement> toList(Map<String, dynamic>? json) {
    List<Movement> movements = [];
    json?['movements'].forEach((move) {
      movements.add(Movement.fromJson(move));
    });
    return movements;
  }
}
