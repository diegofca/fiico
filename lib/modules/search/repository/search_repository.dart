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
              ((e.firstName?.toLowerCase().contains(query.toLowerCase()) ??
                      false) ||
                  (e.email?.toLowerCase().contains(query.toLowerCase()) ??
                      false) ||
                  (e.userName?.toLowerCase().contains(query.toLowerCase()) ??
                      false) ||
                  (e.lastName?.toLowerCase().contains(query.toLowerCase()) ??
                      false)))
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
          .where((e) =>
              (e.name?.toLowerCase().contains(query.toLowerCase()) ?? false) &&
              (e.isActive()))
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
          final b = e.first.movements!.where(
              (e) => e.name!.toLowerCase().contains(query.toLowerCase()));
          movements.addAll(b);
        }
      }
    });
    return Stream.value(movements);
  }
}
