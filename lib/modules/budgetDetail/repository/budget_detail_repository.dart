import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/generic_repository.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class BudgetDetailRepositoryAbs {
  Future<void> addNewMovement(Movement movement, Budget? budget);
  Future<void> deleteMovement(Movement movement, Budget? budget);
  Future<void> removeUserToBudget(FiicoUser? user, Budget budget);
  Future<void> deleteBudget(Budget budget);
  Stream<Budget> getBudget(String? userID);
}

class BudgetDetailRepository extends BudgetDetailRepositoryAbs {
  BudgetDetailRepository(this.budgetID);

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
      Firestore.movementsField: FieldValue.arrayUnion(
        [movement.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final _budget = await getBudget(userID).first;
    return updateBudget(_budget);
  }

  @override
  Future<void> deleteMovement(Movement movement, Budget? budget) async {
    final userID = budget?.getPropertiedID();
    await _movementsCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update({
      Firestore.movementsField: FieldValue.arrayRemove(
        [movement.toJson()],
      ),
    });
    await Future.delayed(const Duration(seconds: 1));

    final _budget = await getBudget(userID).first;
    return updateBudget(_budget);
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

  Future<void> updateBudget(Budget budget) async {
    return BudgetGenericRepository.updateBudget(budget);
  }

  @override
  Future<void> deleteBudget(Budget budget) async {
    final _budget = budget.copyWith(status: 'Disable');
    return updateBudget(_budget);
  }

  @override
  Future<void> removeUserToBudget(FiicoUser? user, Budget budget) async {
    final _budget = budget.copyWith(status: 'Disable', movements: []);

    final getDoc = await _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .where('id', isEqualTo: _budget.id)
        .get();

    final docID = getDoc.docs.first.id;
    return _movementsCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(docID)
        .update(_budget.toJson());
  }
}
