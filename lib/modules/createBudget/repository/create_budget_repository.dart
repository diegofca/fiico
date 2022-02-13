import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/network/firestore_path.dart';

abstract class CreatebudgetRepositoryAbs {
  Future<void> addNewBudget(Budget budget);
  Future<void> updateBudget(Budget budget);
}

class CreateBudgetRepository extends CreatebudgetRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> addNewBudget(Budget budget) {
    // TODO: implement addNewBudget
    throw UnimplementedError();
  }

  @override
  Future<void> updateBudget(Budget budget) {
    // TODO: implement updateBudget
    throw UnimplementedError();
  }
}
