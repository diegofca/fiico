import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreateMovementRepositoryAbs {
  Future<void> addNewMovement(Movement movement);
  Future<Budget> getBudget();
  Future<void> updateMovement(Movement movement);
  Future<void> updatetBudget(Budget budget);
}

class CreateMovementRepository extends CreateMovementRepositoryAbs {
  CreateMovementRepository(this.budgetID);

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

    final budget = await getBudget();
    updatetBudget(budget);
  }

  @override
  Future<Budget> getBudget() async {
    final user = await Preferences.get.getUser();
    return _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }

  @override
  Future<void> updateMovement(Movement movement) {
    return _movementsCollections
        .doc(movement.id.toString())
        .update(movement.toJson());
  }

  @override
  Future<void> updatetBudget(Budget budget) async {
    final user = await Preferences.get.getUser();
    return _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'totalEntry': budget.getTotalEntry(),
      'totalDebt': budget.getTotalDebt(),
      'totalBalance': budget.getTotalBalance(),
    });
  }
}
