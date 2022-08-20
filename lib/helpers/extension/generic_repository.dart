// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages

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
      final userBudget = budget.copyWith(editBudget: budget.isEdited(u.id));
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
        usersCollections
            .doc(u.id)
            .collection(Firestore.budgetsPath)
            .doc(docID)
            .update(userBudget.toJson());
      }
    });

    final ownerBudget = budget!.copyWith(
      editBudget: budget.isEdited(userID),
    );
    // Se actualiza budget a dueño
    return usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(ownerBudget.id)
        .update(ownerBudget.toJson());
  }
}
