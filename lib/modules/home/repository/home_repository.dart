import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';

abstract class HomeRepositoryAbs {
  Future<void> addNewBudget(Budget budget);
  Stream<List<Budget>> budgets();
  Future<Budget> budget();
  Future<void> updateBudget(Budget budget);
}

class HomeRepository extends HomeRepositoryAbs {
  final budgetCollections = FirebaseFirestore.instance.collection('users');

  @override
  Future<void> addNewBudget(Budget budget) {
    return budgetCollections.add(budget.toJson());
  }

  @override
  Future<Budget> budget() {
    return budgetCollections.doc("1").snapshots().map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }

  @override
  Stream<List<Budget>> budgets() {
    return budgetCollections
        .doc("1")
        .collection("budgets")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Budget.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> updateBudget(Budget budget) {
    return budgetCollections.doc(budget.id.toString()).update(budget.toJson());
  }
}
