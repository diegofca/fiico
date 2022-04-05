import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class BudgetDetailRepositoryAbs {
  Future<void> addNewMovement(Movement movement);
  Future<void> deleteMovement(Movement movement);
  Future<void> updateBudget(Budget budget);
  Future<void> deleteBudget(Budget budget);
  Stream<Budget> getBudget(String? userID);
}

class BudgetDetailRepository extends BudgetDetailRepositoryAbs {
  BudgetDetailRepository(this.budgetID);

  final String budgetID;
  final _movementsCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> addNewMovement(Movement movement) async {
    final user = await Preferences.get.getUser();
    await _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayUnion(
        [movement.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final budget = await getBudget(user?.id).first;
    return updateBudget(budget);
  }

  @override
  Future<void> deleteMovement(Movement movement) async {
    final user = await Preferences.get.getUser();
    await _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayRemove(
        [movement.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final budget = await getBudget(user?.id).first;
    return updateBudget(budget);
  }

  @override
  Stream<Budget> getBudget(String? userID) {
    return _movementsCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    });
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    final user = await Preferences.get.getUser();
    return _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update(budget.toJson());
  }

  @override
  Future<void> deleteBudget(Budget budget) async {
    final user = await Preferences.get.getUser();
    return _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .delete();
  }
}
