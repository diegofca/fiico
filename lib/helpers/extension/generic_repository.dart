// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';
import 'package:collection/collection.dart';

class BudgetGenericRepository {
  static final usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  static Future<void> updateBudget(Budget? budget) async {
    final userID = budget?.getPropertiedID();

    // Se actualiza budget a usuarios compartidos.
    budget?.users?.forEach((u) async {
      final getDoc = await usersCollections
          .doc(u.id)
          .collection(Firestore.budgetsPath)
          .where('id', isEqualTo: budget.id)
          .get();

      final docID = getDoc.docs.firstOrNull?.id;
      if (docID == null) {
        usersCollections
            .doc(u.id)
            .collection(Firestore.budgetsPath)
            .add(budget.toJson());
      } else {
        // Se actualiza budget a dueño
        usersCollections
            .doc(u.id)
            .collection(Firestore.budgetsPath)
            .doc(docID)
            .update(budget.toJson());
      }
    });

    return usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budget?.id)
        .update(budget!.toJson());
  }
}
