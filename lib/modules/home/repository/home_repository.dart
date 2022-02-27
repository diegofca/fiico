import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class HomeRepositoryAbs extends BudgetGenericRepositoryAbs {
  Stream<List<Budget>> budgets();
  Future<void> deleteMovement(Movement? movement, String budgetID);
}

class HomeRepository extends HomeRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<Budget>> budgets() {
    return budgetCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Budget.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> deleteMovement(Movement? movement, String budgetID) async {
    await budgetCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayRemove(
        [movement!.toJson()],
      ),
    });

    await Future.delayed(const Duration(seconds: 1));
    final budget = await getBudget(budgetID);
    return updateBudget(budget);
  }

  //Generic ----------------------------------------------------------
  @override
  Future<Budget> getBudget(String budgetID) {
    return budgetCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    return budgetCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budget.id)
        .update({
      'totalEntry': budget.getTotalEntry(),
      'totalDebt': budget.getTotalDebt(),
      'totalBalance': budget.getTotalBalance(),
    });
  }
}
