import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class BiometricIDRepositoryAbs {
  Future<void> updateBiometricUser(FiicoUser? user, bool? enableBiometric);
}

class BiometricIDRepository extends BiometricIDRepositoryAbs {
  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  //Generic ----------------------------------------------------------
  @override
  Future<void> updateBiometricUser(FiicoUser? user, bool? enableBiometric) {
    final updateUser = user?.copyWith(authBiometric: enableBiometric);
    return usersollections.doc(user?.id).update(updateUser?.toJson() ?? {});
  }
}
