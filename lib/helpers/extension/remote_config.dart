// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FiicoRemoteConfig {
  // --
  static const String IOS_VERSION = 'update_version';
  static const String ANDROID_VERSION = 'update_version';
  static const String FORCE_UPDATE = 'force_update';

  static final FirebaseRemoteConfig remoteConfig =
      FirebaseRemoteConfig.instance;

  static Future<bool> fetch() async {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 5),
      minimumFetchInterval: const Duration(seconds: 5), //Duration.zero,
    ));
    // await remoteConfig.activate();
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
}
