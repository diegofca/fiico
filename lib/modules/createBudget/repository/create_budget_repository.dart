import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreatebudgetRepositoryAbs {
  Future<void> addNewBudget(Budget budget);
  Future<void> addUsersShareBudget(Budget budget);
}

class CreateBudgetRepository extends CreatebudgetRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> addNewBudget(Budget budget) async {
    final userID = budget.getPropertiedID();
    var _budget = budget.copyWith(userID: userID);
    final documentAdded = await _usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budget.id)
        .set(budget.toCreateJson());

    await updateIDBudget(_budget);
    await addUsersShareBudget(_budget);
    return documentAdded;
  }

  @override
  Future<void> addUsersShareBudget(Budget budget) async {
    return budget.users?.forEach((u) async {
      await _usersCollections
          .doc(u.id)
          .collection(Firestore.budgetsPath)
          .doc(budget.id)
          .set(budget.toCreateJson());
    });
  }

  Future<void> updateIDBudget(Budget budget) async {
    final userID = budget.getPropertiedID();
    return _usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(budget.id)
        .update(budget.toJson());
  }
}
