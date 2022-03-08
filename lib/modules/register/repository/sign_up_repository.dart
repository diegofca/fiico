import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/register/bloc/sign_bloc.dart';
import 'package:control/network/firestore_path.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpRepositoryAbs {
  Future<FiicoUser?> createUserWithEmail(
      SignState state, Function(String, String?) onError);
}

class SignUpRepository extends SignUpRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<FiicoUser?> createUserWithEmail(
      SignState state, Function(String, String?) onError) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: state.email?.email ?? '',
        password: state.password?.password ?? '',
      );

      final user = FiicoUser(
        id: userCredential.user?.uid,
        email: state.email?.email,
        firstName: state.name?.name,
        lastName: state.lastName?.lastName,
        currentPlan: 'free',
      );
      await _addNewUser(user);
      return _getUser(user.id);
    } on FirebaseAuthException catch (e) {
      onError(e.code, e.message);
    }
    return null;
  }

  Future<void> _addNewUser(FiicoUser user) {
    return _usersCollections
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
  }

  Future<FiicoUser> _getUser(String? id) {
    return _usersCollections.doc(id).snapshots().map((snapshot) {
      return FiicoUser.fromJson(snapshot.data());
    }).first;
  }
}
