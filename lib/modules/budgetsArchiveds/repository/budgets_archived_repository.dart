import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';

abstract class BudgetsArchivedRepositoryAbs {
  Future<Budget> getBudget(String budgetID);
  Future<void> updateBudget(Budget budget);
  Stream<List<Budget>> budgets(String? userID);
}

class BudgetsArchivedRepository extends BudgetsArchivedRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<Budget>> budgets(String? userID) {
    return budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .where(Firestore.statusField, isEqualTo: 'Disable')
        .where('userID', isEqualTo: userID)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Budget.fromJson(doc.data())).toList();
    });
  }

  //Generic ----------------------------------------------------------
  @override
  Future<Budget> getBudget(String budgetID) async {
    final user = await Preferences.get.getUser();
    return budgetCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    return BudgetGenericRepository.updateBudget(budget);
  }
}
