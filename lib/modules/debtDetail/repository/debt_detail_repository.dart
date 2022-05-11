import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/mark_movement.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';
import 'package:collection/collection.dart';

abstract class DebtDetailRepositoryAbs {
  Future<Budget> getBudget(String? userID, String? budgetName);
  Future<void> updateBudget(Budget budget);
  Future<void> markPayed(Budget? budget, Movement? movement);
  Future<void> updateMovement(Movement? movement, Budget? budget);
}

class DebtDetailRepository extends DebtDetailRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override

  //Generic ----------------------------------------------------------
  @override
  Future<Budget> getBudget(String? userID, String? budgetName) async {
    return budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .where(Firestore.nameField, isEqualTo: budgetName)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.docs.first.data());
    }).first;
  }

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
    final _budget = await getBudget(userID, budget?.name);
    return updateBudget(_budget);
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    return BudgetGenericRepository.updateBudget(budget);
  }

  @override
  Future<void> updateMovement(Movement? movement, Budget? budget) async {
    final userID = budget?.getPropertiedID();

    final _budget = await getBudget(userID, budget?.name);

    final oldMovement =
        _budget.movements?.firstWhereOrNull((e) => e.id == movement?.id);

    await budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(_budget.id)
        .update({
      Firestore.movementsField: FieldValue.arrayRemove(
        [oldMovement?.toJson()],
      ),
    });

    await budgetCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(_budget.id)
        .update({
      Firestore.movementsField: FieldValue.arrayUnion(
        [movement?.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final newBudget = await getBudget(userID, budget?.name);
    return updateBudget(newBudget);
  }

  @override
  Future<void> markPayed(Budget? budget, Movement? movement) async {
    final user = await Preferences.get.getUser();
    movement?.markHistory.add(MarkMovement(
      date: Timestamp.now(),
      userName: user?.userName,
      value: movement.value,
    ));
    final newMovement = movement!.copyWith(paymentStatus: 'Payed');
    budget?.movements?.removeWhere((e) => e.id == movement.id);
    budget?.movements?.add(newMovement);
    return BudgetGenericRepository.updateBudget(budget);
  }
}
