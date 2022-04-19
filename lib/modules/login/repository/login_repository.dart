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
  Future<bool?> forgotPasswordWithEmail(
      String email, Function(String, String?) onError);
}

class LoginRepository extends LoginRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<bool?> forgotPasswordWithEmail(
      String email, Function(String, String?) onError) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      onError(e.code, e.message);
    }
    return false;
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
    final userStream = _usersCollections.doc(id).snapshots().map((snapshot) {
      return FiicoUser.fromJson(snapshot.data());
    });
    final user = await userStream.first;
    Preferences.get.saveUser(user);
    return user;
  }
}
