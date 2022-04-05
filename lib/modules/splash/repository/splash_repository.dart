import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/user.dart';

abstract class SplashRepositoryAbs {
  Future<FiicoUser?> getUserTolocalState();
}

class SplashRepository extends SplashRepositoryAbs {
  Preferences preferences = Preferences.get;

  @override
  Future<FiicoUser?> getUserTolocalState() {
    return preferences.getUser();
  }
}
