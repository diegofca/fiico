// ignore_for_file: file_names

import 'package:flutter_app_badger/flutter_app_badger.dart';

class BadgeManager {
  static var count = 0;
  static get pendingBadge => count > 0;

  static void updateBadge(int count) {
    FlutterAppBadger.updateBadgeCount(count);
  }

  static void removeBadge() {
    FlutterAppBadger.removeBadge();
  }
}
