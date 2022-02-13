import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';

abstract class HomeRepositoryAbs {
  Stream<List<Budget>> budgets();
}

class HomeRepository extends HomeRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<Budget>> budgets() {
    return budgetCollections
        .doc("1")
        .collection(Firestore.budgetsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Budget.fromJson(doc.data())).toList();
    });
  }
}
