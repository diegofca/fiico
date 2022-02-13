import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreateMovementRepositoryAbs {
  Future<void> addNewMovement(Movement movement);
  Future<Budget> getBudget();
  Future<void> updateMovement(Movement movement);
}

class CreateMovementRepository extends CreateMovementRepositoryAbs {
  CreateMovementRepository(this.budgetID);

  final String budgetID;
  final _movementsCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> addNewMovement(Movement movement) async {
    return _movementsCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      'movements': FieldValue.arrayUnion([movement.toJson()])
    });
  }

  @override
  Future<Budget> getBudget() {
    return _movementsCollections
        .doc("1")
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
}
