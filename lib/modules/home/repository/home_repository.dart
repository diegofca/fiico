import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class HomeRepositoryAbs {
  Future<Budget> getBudget(String budgetID);
  Future<void> updateBudget(Budget budget);
  Stream<List<Budget>> budgets(String? userID);
  Future<void> deleteMovement(Movement? movement, Budget? budget);
  Future<void> showTutorial(String? userID);
  Future<Budget> getShareBudget(String? userID, Budget budget);
}

class HomeRepository extends HomeRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<Budget>> budgets(String? userID) {
    return budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .where(Firestore.statusField, isEqualTo: 'Active')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Budget.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> deleteMovement(Movement? movement, Budget? budget) async {
    final userID = budget?.getPropertiedID();
    await budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budget?.id)
        .update({
      Firestore.movementsField: FieldValue.arrayRemove(
        [movement!.toJson()],
      ),
    });

    await Future.delayed(const Duration(seconds: 1));
    final _budget = await getBudget(budget!.id);
    return updateBudget(_budget);
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

  @override
  Future<void> showTutorial(String? userID) {
    return budgetCollections.doc(userID).update({
      Firestore.showTutorialField: true,
    });
  }

  @override
  Future<Budget> getShareBudget(String? userID, Budget budget) {
    return budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budget.id)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }
}
