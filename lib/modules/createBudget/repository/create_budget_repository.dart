import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreatebudgetRepositoryAbs {
  Future<DocumentReference<Map<String, dynamic>>> addNewBudget(Budget budget);
  Future<void> updateBudget(
      String? userID, String oldBudgetID, String budgetID);
  Future<void> addUsersShareBudget(String newBudgetID, Budget budget);
}

class CreateBudgetRepository extends CreatebudgetRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<DocumentReference<Map<String, dynamic>>> addNewBudget(
      Budget budget) async {
    final user = await Preferences.get.getUser();
    final _budget = budget.copyWith(userID: user?.id);
    final documentAdded = await _usersCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .add(_budget.toCreateJson());

    await addUsersShareBudget(documentAdded.id, _budget);
    return documentAdded;
  }

  @override
  Future<void> addUsersShareBudget(String newBudgetID, Budget budget) async {
    return budget.users?.forEach((u) async {
      final doc = await _usersCollections
          .doc(u.id)
          .collection(Firestore.budgetsPath)
          .add(budget.copyWith(isOwner: false).toCreateJson());
      await updateBudget(u.id, doc.id, newBudgetID);
    });
  }

  @override
  Future<void> updateBudget(
      String? userID, String oldBudgetID, String budgetID) async {
    return _usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .doc(oldBudgetID)
        .update(
      {
        'id': budgetID,
      },
    );
  }
}
