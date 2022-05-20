import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/plan.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:control/modules/login/repository/providers/login_social_provider.dart';
import 'package:control/network/firestore_path.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class LoginRepositoryAbs {
  Future<FiicoUser?> loginUserWithEmail(
      LoginState state, Function(String, String?) onError);
  Future<bool?> forgotPasswordWithEmail(
      String email, Function(String, String?) onError);
  Future<FiicoUser?> loginUserWithCredential(
      OAuthCredential credential, Function(String, String?) onError);
}

class LoginRepository extends LoginRepositoryAbs {
  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  final provider = LoginSocialProvider();

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

  @override
  Future<FiicoUser?> loginUserWithCredential(
      OAuthCredential? credential, Function(String, String?) onError) async {
    try {
      if (credential != null) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final isNewUser = userCredential.additionalUserInfo?.isNewUser ?? false;
        if (isNewUser) {
          return await _registerUserAfterIntentLogin(
              userCredential, credential);
        }
        return await _getUser(userCredential.user?.uid);
      }
    } on FirebaseAuthException catch (e) {
      onError(e.code, e.message);
    }
    return null;
  }

  Future<bool> validateIfContaintUserWithEmail(
      SocialCredential? credential) async {
    final currentCredential = credential?.userCredential.signInMethod;

    if (credential?.userCredential.providerId == 'apple.com') {
      return true;
    }

    final providers = await FirebaseAuth.instance
        .fetchSignInMethodsForEmail(credential?.email ?? '');
    return providers.isEmpty || providers.contains(currentCredential);
  }

  Future<FiicoUser> _registerUserAfterIntentLogin(
    UserCredential userCredential,
    OAuthCredential? credential,
  ) async {
    final firstName =
        userCredential.additionalUserInfo?.profile?['given_name'] ??
            userCredential.additionalUserInfo?.profile?['first_name'];

    final lastName =
        userCredential.additionalUserInfo?.profile?['family_name'] ??
            userCredential.additionalUserInfo?.profile?['last_name'];

    String token = await FirebaseMessaging.instance.getToken() ?? '';
    final user = FiicoUser(
      id: userCredential.user?.uid,
      email: userCredential.user?.email,
      firstName: firstName,
      lastName: lastName,
      profileImage: userCredential.user?.photoURL,
      userName: userCredential.user?.displayName,
      currentPlan: Plan.free(),
      defaultCurrency: CurrencyService().getAll().first,
      deviceTokens: [token],
      socialToken: credential?.accessToken,
    );
    Preferences.get.saveUser(user);
    await _addNewUser(user);
    return _getUser(user.id);
  }

  Future<void> _addNewUser(FiicoUser user) {
    return _usersCollections
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
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
