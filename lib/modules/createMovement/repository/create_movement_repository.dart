import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreateMovementRepositoryAbs {
  Future<void> addNewMovement(Movement movement, Budget? budget);
  Future<Budget> getBudget(String? userID);
  Future<void> updateMovement(Movement movement, Budget? budget);
  Future<void> updateBudget(Budget budget);
}

class CreateMovementRepository extends CreateMovementRepositoryAbs {
  CreateMovementRepository(this.budgetID);

  final String budgetID;
  final _movementsCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> addNewMovement(Movement movement, Budget? budget) async {
    final userID = budget?.getPropertiedID();
    await _movementsCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayUnion(
        [movement.toJson()],
      ),
    });

    final _budget = await getBudget(userID);
    updateBudget(_budget);
  }

  @override
  Future<Budget> getBudget(String? userID) async {
    return _movementsCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }

  @override
  Future<void> updateMovement(Movement movement, Budget? budget) {
    return _movementsCollections
        .doc(movement.id.toString())
        .update(movement.toJson());
  }

  @override
  Future<void> updateBudget(Budget budget) async {
    return BudgetGenericRepository.updateBudget(budget);
  }
}
