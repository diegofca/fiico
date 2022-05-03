import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/network/firestore_path.dart';

class BudgetCycleHistory {
  final int? id;
  final num? totalPayedDebt;
  final num? totalPendingDebt;
  final num? totalPayedEntry;
  final num? totalPendingEntry;
  final Timestamp? date;

  BudgetCycleHistory({
    this.id = 0,
    this.totalPayedDebt,
    this.totalPendingDebt,
    this.totalPayedEntry,
    this.totalPendingEntry,
    this.date,
  });

  factory BudgetCycleHistory.fromJson(Map<String, dynamic>? json) {
    return BudgetCycleHistory(
      id: json?['id'] ?? 0,
      date: json?['date'] ?? Timestamp.now(),
      totalPayedDebt: json?['totalPayedDebt'],
      totalPendingDebt: json?['totalPendingDebt'] ?? 0,
      totalPayedEntry: json?['totalPayedEntry'] ?? 0,
      totalPendingEntry: json?['totalPendingEntry'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'totalPayedDebt': totalPayedDebt,
      'totalPendingDebt': totalPendingDebt,
      'totalPayedEntry': totalPayedEntry,
      'totalPendingEntry': totalPendingEntry,
    };
  }

  static List<BudgetCycleHistory> toList(Map<String, dynamic>? json) {
    List<BudgetCycleHistory> items = [];
    json?[Firestore.histories]?.forEach((move) {
      items.add(BudgetCycleHistory.fromJson(move));
    });
    return items;
  }

  /// get functions

  String titleCircleOption(int? id) {
    if (id == 0) {
      return 'Today';
    }
    return titleBarOption();
  }

  String titleBarOption() {
    return date?.toDate().toMonthAndYear() ?? '';
  }
}
