import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class SplashRepositoryAbs {
  Future<FiicoUser?> getUserTolocalState();
}

class SplashRepository extends SplashRepositoryAbs {
  Preferences preferences = Preferences.get;

  final _usersCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Future<FiicoUser?> getUserTolocalState() async {
    final user = await preferences.getUser();
    _usersCollections.doc(user?.id).snapshots().listen((value) {
      final updateUser = FiicoUser.fromJson(value.data());
      preferences.saveUser(updateUser);
    });
    return preferences.getUser();
  }
}
