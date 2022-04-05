import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreatebudgetRepositoryAbs {
  Future<DocumentReference<Map<String, dynamic>>> addNewBudget(Budget budget);
  Future<void> updateBudget(String budgetID);
}

class CreateBudgetRepository extends CreatebudgetRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<DocumentReference<Map<String, dynamic>>> addNewBudget(
      Budget budget) async {
    final user = await Preferences.get.getUser();
    return _usersCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .add(budget.toCreateJson());
  }

  @override
  Future<void> updateBudget(String budgetID) async {
    final user = await Preferences.get.getUser();
    return _usersCollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .update(
      {
        'id': budgetID,
        'userID': user?.id,
      },
    );
  }
}
