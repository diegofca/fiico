import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/extension/toast.dart';
import 'package:control/helpers/manager/badgeManager.dart';
import 'package:control/models/notification_center_option.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:control/modules/movementList/view/movement_list_page.dart';
import 'package:control/modules/notifications/view/notifications_page.dart';
import 'package:control/modules/settings/view/pages/helpCenter/view/help_center_dart.dart';
import 'package:control/modules/subscriptionDetail/view/subscription_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class FirebaseManager {
  static late BuildContext _context;

  static Future<void> init() async {
    await Firebase.initializeApp();
    await FiicoRemoteConfig.fetch();
    _initFirestore();
    _initRemoteConfig();
    _initMessaging();
    _initCrashlytics();
    _initAnalytics();
    _initInAppMessaging();
  }

  static void addContext(BuildContext context) {
    FirebaseManager._context = context;
  }

  static void _initFirestore() {
    FirebaseFirestore.instance.settings = const Settings(
      sslEnabled: false,
      persistenceEnabled: false,
    );
  }

  static void _initAnalytics() {
    FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
  }

  static void _initCrashlytics() {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  }

  static void _initRemoteConfig() {
    FiicoRemoteConfig.fetch();
  }

  static void _initMessaging() {
    FirebaseMessaging.instance.requestPermission(
      sound: true,
      badge: true,
      alert: true,
    );
    FirebaseMessaging.instance.setAutoInitEnabled(true);
    _callbackMessaging();
  }

  static void _initInAppMessaging() {
    FirebaseInAppMessaging.instance.setAutomaticDataCollectionEnabled(true);
  }

  /// --- Callback Firebase Messaging.  ------
  static void _callbackMessaging() {
    // Mensaje nuevo
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      FirebaseManager._receivedNotification(message);
      BadgeManager.updateBadge(1);
    });
    // Mensaje nuevo en cola
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      FirebaseManager._receivedNotification(message);
    });
    // Mensaje abierto
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      FirebaseManager._openNotification(message);
      BadgeManager.removeBadge();
    });
  }

  static void _openNotification(RemoteMessage? message) async {
    final user = await Preferences.get.getUser();
    if (message != null) {
      switch (message.data['action']) {
        case "ALERT_MOVEMENT":
          final budgetID = message.data['actionId'];
          final budget = await HomeRepository().getBudget(budgetID);
          FiicoRoute.send(_context, MovementsListPage(budget: budget));
          break;
        case "PREMIUM":
          FiicoRoute.send(_context, SubscriptionDetailPage(user: user));
          break;
        case "NEWS":
          FiicoRoute.send(_context, NotificationsPage(user: user));
          break;
        case "HELPCENTER":
          FiicoRoute.send(_context, HelpCenterPage(user: user));
          break;
        default:
      }
    }
  }

  static void _receivedNotification(RemoteMessage? message) {
    if (message != null) {
      FiicoToast.showLocalNotification(
        message,
        onTap: () => _openNotification(message),
      );
    }
  }

  static void topic(NotificationCenterOption? topic) async {
    final user = await Preferences.get.getUser();
    var topicValue = topic?.key ?? '';
    if (!(topic?.generic ?? false)) {
      topicValue = '$topicValue${user?.id}';
    }

    if (topic?.enable ?? false) {
      await FirebaseMessaging.instance.subscribeToTopic(topicValue);
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topicValue);
    }
  }

  static void removeTopics() {
    FirebaseMessaging.instance.deleteToken();
  }
}
