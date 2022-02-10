import 'dart:ui';

import 'package:control/helpers/extension/colors.dart';
import 'package:control/models/movement.dart';

class Budget {
  final int? id;
  final String? name;

  final String? currency;
  final int? cycle;
  final String? icon;
  final String? status;
  final int? totalBalance;
  final int? totalDebt;
  final int? totalEntry;
  final String? userID;
  final List<Movement>? movements;

  Budget({
    this.id,
    this.name,
    this.currency,
    this.cycle,
    this.icon,
    this.status,
    this.totalBalance,
    this.totalDebt,
    this.totalEntry,
    this.userID,
    this.movements,
  });

  factory Budget.fromJson(Map<String, dynamic>? json) {
    return Budget(
      id: json?['id'],
      name: json?['name'],
      currency: json?['currency'] ?? '',
      cycle: json?['cycle'] ?? 1,
      icon: json?['icon'] ?? '',
      status: json?['status'] ?? '',
      totalBalance: json?['totalBalance'] ?? 0,
      totalDebt: json?['totalDebt'] ?? 0,
      totalEntry: json?['totalEntry'] ?? 0,
      userID: json?['userID'] ?? '',
      movements: Movement.toList(json),
    );
  }

  Map<String, String?> toJson() {
    return {
      'id': id.toString(),
      // 'firstName': name ?? "",
      // 'lastName': reason ?? "other",
      // 'userName': "${initDate?.getDateString("yyyy-MM-dd hh:mm:ss")}",
      // 'email': "${endDate()?.getDateString("yyyy-MM-dd hh:mm:ss")}",
      // 'socialToken': pricePerMember.toString(),
      // 'deviceTokens': randomOrder ?? false ? 1.toString() : 2.toString(),
      // 'vip': isDeduct ?? false ? 1.toString() : 2.toString(),
      // 'currentPlan': inviteUsers.length.toString(),
      // 'budgets': 3.toString(),
    };
  }

  // Functions class ----------------------------------------------------
  bool isEmptyMovements() {
    return movements?.isEmpty ?? false;
  }

  Color getStatusColor() {
    switch (status) {
      case "Active":
        return FiicoColors.greenNeutral;
      default:
        return FiicoColors.gold;
    }
  }
}
