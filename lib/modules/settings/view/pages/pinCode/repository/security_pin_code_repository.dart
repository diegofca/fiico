import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class SecurityPinCodeRepositoryAbs {
  Future<void> updateUser(FiicoUser? user, String securityCode);
}

class SecurityPinCodeRepository extends SecurityPinCodeRepositoryAbs {
  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  //Generic ----------------------------------------------------------
  @override
  Future<void> updateUser(FiicoUser? user, String? securityCode) {
    final updateUser = user?.copyWith(securityCode: securityCode);
    return usersollections.doc(user?.id).update(updateUser?.toJson() ?? {});
  }
}
