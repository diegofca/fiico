import 'dart:ui';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/models/movement.dart';

class Budget {
  final String id;
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
    required this.id,
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

  Budget.create({
    required this.id,
    this.name,
    this.currency,
    this.cycle = 1,
    this.icon = '',
    this.status = 'pending',
    this.totalBalance = 0,
    this.totalDebt = 0,
    this.totalEntry = 0,
    this.userID,
    this.movements = const [],
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'cycle': cycle,
      'icon': icon,
      'status': status,
      'totalBalance': totalBalance,
      'totalDebt': totalDebt,
      'totalEntry': totalEntry,
      'userID': userID,
    };
  }

  static List<Budget> toList(Map<String, dynamic>? json) {
    List<Budget> budgets = [];
    json?['budgets'].forEach((budget) {
      budgets.add(Budget.fromJson(budget));
    });
    return budgets;
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
