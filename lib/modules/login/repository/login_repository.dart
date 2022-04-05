import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:control/network/firestore_path.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepositoryAbs {
  Future<FiicoUser?> loginUserWithEmail(
      LoginState state, Function(String, String?) onError);
  Future<void> forgotPasswordWithEmail(String email);
}

class LoginRepository extends LoginRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<void> forgotPasswordWithEmail(String email) {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  @override
  Future<FiicoUser?> loginUserWithEmail(
      LoginState state, Function(String, String?) onError) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email?.email ?? '',
        password: state.password?.password ?? '',
      );
      return await _getUser(userCredential.user?.uid);
    } on FirebaseAuthException catch (e) {
      onError(e.code, e.message);
    }
    return null;
  }

  Future<FiicoUser> _getUser(String? id) async {
    final user = await _usersCollections.doc(id).snapshots().map((snapshot) {
      return FiicoUser.fromJson(snapshot.data());
    }).first;
    Preferences.get.saveUser(user);
    return user;
  }
}
