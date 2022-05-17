import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Plan {
  final String id;
  final String? name;
  final String? icon;
  final bool? enable;
  final bool? unlimited;
  Timestamp? startDate = Timestamp.now();
  Timestamp? endDate = Timestamp.now();
  String? priceDetail;
  String? paymentID;

  Plan({
    required this.id,
    required this.name,
    required this.icon,
    this.startDate,
    this.endDate,
    this.enable,
    this.unlimited,
    this.priceDetail,
    this.paymentID,
  });

  Plan copyWith({
    String? id,
    String? name,
    String? icon,
    bool? enable,
    bool? unlimited,
    Timestamp? startDate,
    Timestamp? endDate,
    String? priceDetail,
    String? paymentID,
  }) {
    return Plan(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      enable: enable ?? this.enable,
      unlimited: unlimited ?? this.unlimited,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      priceDetail: priceDetail ?? this.priceDetail,
      paymentID: paymentID ?? this.paymentID,
    );
  }

  Plan.free({
    this.id = 'free',
    this.name = 'Plan Gratis',
    this.icon = 'material_design_icons_flutter',
    this.enable = true,
    this.unlimited = false,
  });

  Plan.premiumUnlimited({
    this.id = 'valiu_premium_unlimited',
    this.name = 'Plan Premium',
    this.icon = SVGImages.unlimitedPremium,
    this.enable = true,
    this.unlimited = true,
    this.endDate,
  });

  Plan.goldPremium({
    this.id = 'valiu_premium_gold',
    this.name = 'Plan Premium Oro',
    this.icon = SVGImages.goldPremium,
    this.enable = true,
    this.unlimited = false,
    this.endDate,
  });

  Plan.diamondPremium({
    this.id = 'valiu_premium_diamond',
    this.name = 'Plan Premium Diamante',
    this.icon = SVGImages.diamondPremium,
    this.enable = true,
    this.unlimited = false,
    this.endDate,
  });

  void addPrice(String priceDetail) {
    this.priceDetail = priceDetail;
  }

  static Plan getPlanByID(String id) {
    switch (id) {
      case 'valiu_premium_unlimited':
        return Plan.premiumUnlimited();
      case 'valiu_premium_gold':
        return Plan.goldPremium(
          endDate: Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 30)),
          ),
        );
      case 'valiu_premium_diamond':
        return Plan.diamondPremium(
          endDate: Timestamp.fromDate(
            DateTime.now().add(const Duration(days: 180)),
          ),
        );
      default:
        return Plan.free();
    }
  }

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
    final unlimited = isUnlimited() ? FiicoLocale().unlimited : '';
    return '$name $unlimited';
  }

  String getStatusTitle() {
    return enable ?? false ? FiicoLocale().active : FiicoLocale().inactive;
  }

  String getFinisthDate() {
    final _endDate = endDate?.toDate().toDateFormat2() ?? '';
    return isUnlimited()
        ? FiicoLocale().yourPlanIsUnlimited
        : isPremium()
            ? _endDate
            : FiicoLocale().dareToImproveYourPlan;
  }

  String getFinisthDateTitle() {
    return isPremium() && !isUnlimited() ? 'Vence el' : '';
  }

  String getDurationTitle() {
    switch (id) {
      case 'valiu_premium_unlimited':
        return 'Ahorra mucho más, unica compra';
      case 'valiu_premium_gold':
        return 'valor por 1 mes';
      case 'valiu_premium_diamond':
        return 'valor por 6 meses';
      default:
        return '';
    }
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
