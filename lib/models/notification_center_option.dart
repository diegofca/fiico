import 'package:control/network/firestore_path.dart';

class NotificationCenterOption {
  final int id;
  final String name;
  final String key;
  final bool generic;

  bool? enable;

  NotificationCenterOption({
    required this.id,
    required this.name,
    required this.key,
    required this.generic,
    this.enable = true,
  });

  factory NotificationCenterOption.fromJson(Map<String, dynamic>? json) {
    return NotificationCenterOption(
      id: json?['id'],
      name: json?['name'],
      key: json?['key'],
      enable: json?['enable'],
      generic: json?['generic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'key': key,
      'enable': enable,
      'generic': generic,
    };
  }

  NotificationCenterOption copyWith({
    int? id,
    String? name,
    String? key,
    bool? enable,
    bool? generic,
  }) {
    return NotificationCenterOption(
      id: id ?? this.id,
      name: name ?? this.name,
      key: key ?? this.key,
      enable: enable ?? this.enable,
      generic: generic ?? this.generic,
    );
  }

  static List<NotificationCenterOption> toList(Map<String, dynamic>? json) {
    List<NotificationCenterOption> options = [];
    json?[Firestore.notificationOptions]?.forEach((option) {
      options.add(NotificationCenterOption.fromJson(option));
    });
    return options;
  }
}
