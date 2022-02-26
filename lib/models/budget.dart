// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/models/cycle.dart';
import 'package:control/models/duration.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/modules/home/model/home_filters_movements.dart';
import 'package:flutter/cupertino.dart';

class Budget {
  final String id;
  final String? name;
  final String? currency;
  final int? cycle;
  final FiicoIcon? icon;
  final String? status;
  final num? totalBalance;
  final num? totalDebt;
  final num? totalEntry;
  final String? userID;
  final List<Movement>? movements;
  final bool? isCycle;
  final Timestamp? startDate;
  final Timestamp? finishDate;

  final int? duration;

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
    this.isCycle,
    this.movements,
    this.startDate,
    this.finishDate,
    this.duration,
  });

  Budget.create({
    required this.id,
    this.name,
    this.currency,
    this.cycle = 2,
    this.icon = const FiicoIcon.empty(),
    this.status = 'pending',
    this.totalBalance = 0,
    this.totalDebt = 0,
    this.totalEntry = 0,
    this.userID,
    this.isCycle = true,
    this.movements = const [],
    this.startDate,
    this.finishDate,
    this.duration = 3,
  });

  factory Budget.fromJson(Map<String, dynamic>? json) {
    return Budget(
      id: json?['id'],
      name: json?['name'],
      currency: json?['currency'] ?? '',
      cycle: json?['cycle'] ?? 1,
      duration: json?['duration'] ?? 1,
      icon: FiicoIcon.fromJson(json?['icon']),
      status: json?['status'] ?? '',
      totalBalance: json?['totalBalance'] ?? 0.0,
      totalDebt: json?['totalDebt'] ?? 0,
      totalEntry: json?['totalEntry'] ?? 0,
      userID: json?['userID'] ?? '',
      isCycle: json?['isCycle'] ?? false,
      startDate: json?['startDate'] ?? Timestamp.now(),
      finishDate: json?['finishDate'] ?? Timestamp.now(),
      movements: Movement.toList(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'currency': currency,
      'cycle': cycle,
      'duration': duration,
      'status': status,
      'totalBalance': totalBalance,
      'totalDebt': totalDebt,
      'totalEntry': totalEntry,
      'userID': userID,
      'isCycle': isCycle,
      'startDate': startDate,
      'finishDate': finishDate,
      'icon': icon?.toJson(),
      'movements': FieldValue.arrayUnion(
          movements?.map((e) => e.toJson()).toList() ?? []),
    };
  }

  Map<String, dynamic> toCreateJson() {
    return {
      'id': id,
      'status': "Active",
      'name': name,
      'currency': currency,
      'cycle': cycle,
      'duration': duration,
      'icon': icon,
      'totalBalance': getTotalBalance(),
      'totalDebt': getTotalDebt(),
      'totalEntry': getTotalEntry(),
      'userID': userID,
      'isCycle': isCycle,
      'startDate': startDate,
      'finishDate': finishDate,
      'movements': FieldValue.arrayUnion(
          movements?.map((e) => e.toJson()).toList() ?? []),
    };
  }

  static List<Budget> toList(Map<String, dynamic>? json) {
    List<Budget> budgets = [];
    json?['budgets'].forEach((budget) {
      budgets.add(Budget.fromJson(budget));
    });
    return budgets;
  }

  // Functions class -----------------------------------------------------------------------------------------
  bool isEmptyMovements() {
    return movements?.isEmpty ?? false;
  }

  double getTotalEntry() {
    final entrys = movements?.where((e) => e.getType() == MovementType.ENTRY);
    double total = 0;
    entrys?.forEach((e) {
      total += e.value ?? 0;
    });
    return total;
  }

  double getTotalDebt() {
    final entrys = movements?.where((e) => e.getType() == MovementType.DEBT);
    double total = 0;
    entrys?.forEach((e) {
      total += e.value ?? 0;
    });
    return total;
  }

  double getTotalBalance() {
    return getTotalEntry() - getTotalDebt();
  }

  Color getStatusColor() {
    switch (status) {
      case "Active":
        return FiicoColors.greenNeutral;
      default:
        return FiicoColors.gold;
    }
  }

  String getCycleText() {
    final type = BudgetCycleType.values
        .firstWhereOrNull((element) => element.index == cycle);
    switch (type) {
      case BudgetCycleType.WEEK:
        return 'Semanal';
      case BudgetCycleType.TWO_WEEKS:
        return 'Cada dos semanas';
      case BudgetCycleType.MONTH:
        return 'Mensual';
      case BudgetCycleType.THREE_MONTH:
        return 'Cada tres meses';
      case BudgetCycleType.SIX_MONTH:
        return 'Cada seis meses';
      case BudgetCycleType.ANNUAL:
        return 'Anual';
      default:
        return 'Selecciona el ciclo de tiempo';
    }
  }

  String getDurationText() {
    final type = BudgetDurationType.values
        .firstWhereOrNull((element) => element.index == duration);
    switch (type) {
      case BudgetDurationType.CUSTOM:
        return 'Personalizado';
      case BudgetDurationType.MONTH:
        return 'Mensual';
      case BudgetDurationType.THREE_MONTH:
        return 'Cada tres meses';
      case BudgetDurationType.SIX_MONTH:
        return 'Cada seis meses';
      case BudgetDurationType.ANNUAL:
        return 'Anual';
      default:
        return '';
    }
  }

  bool isCustomDuration() {
    final type = BudgetDurationType.values
        .firstWhereOrNull((element) => element.index == duration);
    return type == BudgetDurationType.CUSTOM;
  }

  Timestamp getFinishDate() {
    final type = BudgetDurationType.values
        .firstWhereOrNull((element) => element.index == duration);

    var date = startDate?.toDate() ?? DateTime.now();

    switch (type) {
      case BudgetDurationType.MONTH:
        return Timestamp.fromDate(date.add(const Duration(days: 30)));

      case BudgetDurationType.THREE_MONTH:
        return Timestamp.fromDate(date.add(const Duration(days: 90)));

      case BudgetDurationType.SIX_MONTH:
        return Timestamp.fromDate(date.add(const Duration(days: 180)));

      case BudgetDurationType.ANNUAL:
        return Timestamp.fromDate(date.add(const Duration(days: 365)));

      case BudgetDurationType.CUSTOM:
        return Timestamp.fromDate(finishDate?.toDate() ?? date);

      default:
        return Timestamp.fromDate(date);
    }
  }

  //  Ger Orders by movements
  List<Movement>? getMovementsBy(int key) {
    final filterSelected =
        HomeFilterMovement.itemsFilter.entries.firstWhere((e) => e.key == key);

    switch (filterSelected.key) {
      case 0: // Mas recientes
        return movements?.sorted(
            (a, b) => b.createdAt!.toDate().compareTo(a.createdAt!.toDate()));
      case 1: // De menor a mayor
        return movements?.sortedBy<num>((e) => e.value ?? 0);
      case 2: // De mayor a menor
        return movements?.sortedBy<num>((e) => e.value ?? 0).reversed.toList();
      case 3: // Solo ingresos
        return movements
            ?.where((e) => e.getType() == MovementType.ENTRY)
            .toList();
      case 4: // Solo gastos
        return movements
            ?.where((e) => e.getType() == MovementType.DEBT)
            .toList();
      default:
        return movements;
    }
  }
}
