import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class ChangeLanguageRepositoryAbs {
  Future<void> updateLanguageUser(FiicoUser? user, String? language);
}

class ChangeLanguageRepository extends ChangeLanguageRepositoryAbs {
  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  //Generic ----------------------------------------------------------
  @override
  Future<void> updateLanguageUser(FiicoUser? user, String? language) {
    final updateUser = user?.copyWith(languageCode: language);
    return usersollections.doc(user?.id).update(updateUser?.toJson() ?? {});
  }
}
