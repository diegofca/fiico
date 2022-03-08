import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class SearchUsersRepositoryAbs {
  Stream<List<FiicoUser>> searchUsers();
}

class SearchUsersRepository extends SearchUsersRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);
  @override
  Stream<List<FiicoUser>> searchUsers() {
    return _usersCollections
        .where("id", isNotEqualTo: 1)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FiicoUser.fromJson(doc.data()))
          .toList();
    });
  }
}
