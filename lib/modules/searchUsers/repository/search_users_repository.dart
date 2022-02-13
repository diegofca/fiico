import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class SearchUsersRepositoryAbs {
  Stream<List<User>> searchUsers();
}

class SearchUsersRepository extends SearchUsersRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);
  @override
  Stream<List<User>> searchUsers() {
    return _usersCollections.where('field').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
    });
  }
}
