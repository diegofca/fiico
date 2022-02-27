import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class BudgetDetailRepositoryAbs {
  Future<void> addNewMovement(Movement movement);
  Future<void> deleteMovement(Movement movement);
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(Budget budget);
  Stream<Budget> getBudget();
}

class BudgetDetailRepository extends BudgetDetailRepositoryAbs {
  BudgetDetailRepository(this.budgetID);

  final String budgetID;
  final _movementsCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> addNewMovement(Movement movement) async {
    await _movementsCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayUnion(
        [movement.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final budget = await getBudget().first;
    return updateBudget(budget);
  }

  @override
  Future<void> deleteMovement(Movement movement) async {
    await _movementsCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayRemove(
        [movement.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final budget = await getBudget().first;
    return updateBudget(budget);
  }

  @override
  Stream<Budget> getBudget() {
    return _movementsCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    });
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    return _movementsCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'totalEntry': budget.getTotalEntry(),
      'totalDebt': budget.getTotalDebt(),
      'totalBalance': budget.getTotalBalance(),
    });
  }

  @override
  Future<void> deleteBudget(Budget budget) {
    return _movementsCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .delete();
  }
}
