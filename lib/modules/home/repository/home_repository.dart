import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class HomeRepositoryAbs extends BudgetGenericRepositoryAbs {
  Stream<List<Budget>> budgets(String? userID);
  Future<void> deleteMovement(Movement? movement, String budgetID);
}

class HomeRepository extends HomeRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<Budget>> budgets(String? userID) {
    return budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Budget.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> deleteMovement(Movement? movement, String budgetID) async {
    final user = await Preferences.get.getUser();
    await budgetCollections
        .doc(user?.id)
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
    final user = await Preferences.get.getUser();
    return budgetCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budget.id)
        .update({
      'totalEntry': budget.getTotalEntry(),
      'totalDebt': budget.getTotalDebt(),
      'totalBalance': budget.getTotalBalance(),
    });
  }
}
