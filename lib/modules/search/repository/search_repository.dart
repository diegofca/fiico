import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class SearchRepositoryAbs {
  Stream<List<FiicoUser>> searchUsers(String? userID, String query);
  Stream<List<Budget>> searchBudgets(String? userID, String query);
  Stream<List<Movement>> searchMovements(String? userID, String query);
}

class SearchRepository extends SearchRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);
  @override
  Stream<List<FiicoUser>> searchUsers(String? userID, String query) {
    searchBudgets(userID, query);
    return _usersCollections.snapshots().map((snapshot) {
      return snapshot.docs // Filter users with query
          .map((doc) => FiicoUser.fromJson(doc.data()))
          .where((e) =>
              (e.id != userID) &&
              ((e.email?.contains(query) ?? false) ||
                  (e.firstName?.contains(query) ?? false) ||
                  (e.userName?.contains(query) ?? false) ||
                  (e.lastName?.contains(query) ?? false)))
          .toList();
    });
  }

  @override
  Stream<List<Budget>> searchBudgets(String? userID, String query) {
    return _usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs // Filter budgets with query
          .map((doc) => Budget.fromJson(doc.data()))
          .toList()
          .where((e) => (e.name?.contains(query) ?? false) && (e.isActive()))
          .toList();
    });
  }

  @override
  Stream<List<Movement>> searchMovements(String? userID, String query) {
    final streamResult = _usersCollections
        .doc(userID)
        .collection(Firestore.budgetsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs // Filter budgets with query
          .map((doc) => Budget.fromJson(doc.data()))
          .where((e) => e.isActive());
    });

    List<Movement> movements = [];
    streamResult.forEach((e) async {
      if (e.isNotEmpty) {
        if (e.first.movements?.isNotEmpty ?? false) {
          final b = e.first.movements!.where((e) => e.name!.contains(query));
          movements.addAll(b);
        }
      }
    });
    return Stream.value(movements);
  }
}
