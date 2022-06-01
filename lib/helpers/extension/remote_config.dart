// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FiicoRemoteConfig {
  // --
  static const String IOS_VERSION = 'ios_version';
  static const String ANDROID_VERSION = 'android_version';
  static const String FORCE_UPDATE = 'force_update';
  static const String BUDGETS_LIMIT = 'free_budgets_limit';
  static const String DEBTS_LIMIT = 'free_debts_limit';
  static const String ENTRYS_LIMIT = 'free_entrys_limit';

  static final FirebaseRemoteConfig remoteConfig =
      FirebaseRemoteConfig.instance;

  static Future<bool> fetch() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(seconds: 5), //Duration.zero,
    ));
    await remoteConfig.activate();
    await Future.delayed(const Duration(seconds: 1));
    return remoteConfig.fetchAndActivate();
  }

  static Future<bool> isShowUpdateVersion() async {
    await remoteConfig.fetch();

    final key = Platform.isIOS
        ? FiicoRemoteConfig.IOS_VERSION
        : FiicoRemoteConfig.ANDROID_VERSION;
    final updateVersion = remoteConfig.getString(key);
    int updateVersionValue = int.parse(updateVersion.replaceAll('.', ''));

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int version = int.parse(packageInfo.version.replaceAll('.', ''));

    return updateVersionValue > version;
  }

  static bool isForceUpdateVersion() {
    final forceUpdate = remoteConfig.getBool(FiicoRemoteConfig.FORCE_UPDATE);
    return forceUpdate;
  }

  static Future<bool> isCanCreateBudget() async {
    final user = await Preferences.get.getUser();
    final freeBudgetsLimit =
        remoteConfig.getInt(FiicoRemoteConfig.BUDGETS_LIMIT);
    return (user?.isPremium() ?? false) ||
        freeBudgetsLimit > (user?.totalBudgets ?? 0);
  }

  static Future<bool> isCanCreateMovement(
    MovementType? movementType,
    Budget? budget,
  ) async {
    if (movementType == MovementType.ENTRY) {
      return _isCanCreateMovementEntrys(budget);
    } else {
      return _isCanCreateMovementDebts(budget);
    }
  }

  static Future<bool> _isCanCreateMovementEntrys(Budget? budget) async {
    final user = await Preferences.get.getUser();
    final freeMovementsLimit =
        remoteConfig.getInt(FiicoRemoteConfig.ENTRYS_LIMIT);
    return (user?.isPremium() ?? false) ||
        freeMovementsLimit > (budget?.getMovementsBy(3)?.length ?? 0);
  }

  static Future<bool> _isCanCreateMovementDebts(Budget? budget) async {
    final user = await Preferences.get.getUser();
    final freeMovementsLimit =
        remoteConfig.getInt(FiicoRemoteConfig.DEBTS_LIMIT);
    return (user?.isPremium() ?? false) ||
        freeMovementsLimit > (budget?.getMovementsBy(4)?.length ?? 0);
  }
}
