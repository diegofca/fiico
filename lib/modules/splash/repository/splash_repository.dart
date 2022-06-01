import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

abstract class SplashRepositoryAbs {
  Future<FiicoUser?> getUserTolocalState();
}

class SplashRepository extends SplashRepositoryAbs {
  Preferences preferences = Preferences.get;

  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<FiicoUser?> getUserTolocalState() async {
    var user = await preferences.getUser();
    _usersCollections.doc(user?.id).snapshots().listen((value) {
      if (value.exists) {
        final updateUser = FiicoUser.fromJson(value.data());
        preferences.saveUser(updateUser);
      }
    });
    _updateUserToken();
    return preferences.getUser();
  }

  void _updateUserToken() async {
    var user = await preferences.getUser();
    if (user != null) {
      String token = await FirebaseMessaging.instance.getToken() ?? '';
      user = user.copyWith(deviceTokens: [token]);
      _usersCollections.doc(user.id).update(user.toJson());
    }
  }
}
