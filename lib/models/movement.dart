import 'package:cloud_firestore/cloud_firestore.dart';

class Movement {
  final int id;
  final String name;
  final num value;
  final Timestamp createAt;
  final String image;
  final String type;
  final String description;

  Movement({
    required this.id,
    required this.name,
    required this.value,
    required this.createAt,
    required this.image,
    required this.type,
    required this.description,
  });

  factory Movement.fromJson(Map<String, dynamic>? json) {
    return Movement(
      id: json?['id'],
      name: json?['name'],
      value: json?['value'],
      createAt: json?['createAt'],
      image: json?['image'],
      type: json?['type'],
      description: json?['description'],
    );
  }

  static List<Movement> toList(Map<String, dynamic>? json) {
    List<Movement> movements = [];
    json?['movements'].forEach((move) {
      movements.add(Movement.fromJson(move));
    });
    return movements;
  }
}
