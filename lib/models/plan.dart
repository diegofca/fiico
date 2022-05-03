import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Plan {
  final int id;
  final String? name;
  final String? icon;
  final bool? enable;
  final bool? unlimited;
  Timestamp? startDate = Timestamp.now();
  Timestamp? endDate = Timestamp.now();

  Plan({
    required this.id,
    required this.name,
    required this.icon,
    this.startDate,
    this.endDate,
    this.enable,
    this.unlimited,
  });

  Plan.free({
    this.id = 0,
    this.name = 'Free',
    this.icon = 'material_design_icons_flutter',
    this.enable = true,
    this.unlimited = false,
  });

  factory Plan.fromJson(Map<String, dynamic>? json) {
    return Plan(
      id: json?['id'] ?? 0,
      name: json?['name'] ?? '',
      icon: json?['icon'] ?? '',
      enable: json?['enable'] ?? false,
      unlimited: json?['unlimited'] ?? false,
      startDate: _getDate(json?['startDate']),
      endDate: _getDate(json?['endDate']),
    );
  }

  static Timestamp _getDate(dynamic date) {
    if (date is String) {
      return Timestamp.fromDate(DateTime.parse(date));
    }
    return date ?? Timestamp.now();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startDate': startDate?.toDate().toIso8601String(),
      'endDate': endDate?.toDate().toIso8601String(),
      'unlimited': unlimited,
      'enable': enable,
      'name': name,
      'icon': icon,
    };
  }

  /// Generic class functions

  bool isPremium() {
    return name != 'Free';
  }

  bool isUnlimited() {
    return unlimited ?? false;
  }

  String getPlanTitle() {
    final unlimited = isUnlimited() ? 'Ilimitado' : '';
    return 'Plan $name $unlimited';
  }

  String getStatusTitle() {
    return enable ?? false ? 'Activo' : 'Inactivo';
  }

  String getFinisthDate() {
    final _endDate = endDate?.toDate().toDateFormat2() ?? '';
    return isUnlimited()
        ? '¡Tu plan es Ilimitado!'
        : isPremium()
            ? _endDate
            : 'Atreveté a mejorar tu plan';
  }

  String getFinisthDateTitle() {
    return isPremium() && !isUnlimited() ? 'Vence el' : '';
  }

  Color getStatusColor() {
    return enable ?? false ? FiicoColors.greenNeutral : FiicoColors.pinkRed;
  }

  Color getStatusIconColor() {
    return (enable ?? false) && (name != 'Free')
        ? FiicoColors.gold
        : FiicoColors.purpleSoft;
  }

  IconData getStatusIcon() {
    return (enable ?? false) && (name != 'Free')
        ? MdiIcons.crownOutline
        : Icons.savings_rounded;
  }
}
