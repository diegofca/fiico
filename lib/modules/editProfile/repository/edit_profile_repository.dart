import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class EditProfileRepositoryAbs {
  Future<void> updateProfile(FiicoUser user);
}

class EditProfileRepository extends EditProfileRepositoryAbs {
  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  //Generic ----------------------------------------------------------
  @override
  Future<void> updateProfile(FiicoUser? user) {
    return usersollections.doc(user?.id).update(user?.toJson() ?? {});
  }
}
