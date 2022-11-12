import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';
import 'package:collection/collection.dart';

abstract class SearchUsersRepositoryAbs {
  Stream<List<FiicoUser>> searchUsers(String? userID);
}

class SearchUsersRepository extends SearchUsersRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);
  @override
  Stream<List<FiicoUser>> searchUsers(String? userID) {
    return _usersCollections
        .doc(userID)
        .collection(Firestore.friendsPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FiicoUser.fromJson(doc.data()))
          .sortedBy<String>((e) => e.firstName!)
          .toList();
    });
  }
}
