import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/manager/firebase_manager.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/plan.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/register/bloc/sign_bloc.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/repository/notification_center_repository.dart';
import 'package:control/network/firestore_path.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

      String token = await FirebaseMessaging.instance.getToken() ?? '';
      final user = FiicoUser(
        id: userCredential.user?.uid,
        email: state.email?.email,
        firstName: state.name?.name,
        lastName: state.lastName?.lastName,
        userName: '${state.name?.name} ${state.lastName?.lastName}',
        currentPlan: Plan.free(),
        defaultCurrency: state.currency ?? CurrencyService().getAll().first,
        languageCode: FiicoLocale.locale.toLanguageTag(),
        notificationsOptions: NotificationCenterRepository().options,
        deviceTokens: [token],
      );

      Preferences.get.saveUser(user);
      _suscribesTopicsUpdate(user);
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

  void _suscribesTopicsUpdate(FiicoUser user) async {
    user.notificationsOptions?.forEach((topic) {
      FirebaseManager.topic(topic);
    });
  }
}
