import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/extension/toast.dart';
import 'package:control/navigation/navigator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseManager {
  static late BuildContext _context;

  static Future<void> init() async {
    await Firebase.initializeApp();
    FiicoRemoteConfig.fetch();
    _initFirestore();
    _initRemoteConfig();
    _initMessaging();
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

  /// --- Callback Firebase Messaging.  ------
  static void _callbackMessaging() {
    // Mensaje nuevo
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      FirebaseManager._receivedNotification(message);
    });
    // Mensaje nuevo en cola
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      FirebaseManager._receivedNotification(message);
    });
    // Mensaje abierto
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      FirebaseManager._openNotification(message);
    });
  }

  static void _openNotification(RemoteMessage? message) {
    if (message != null) {
      FiicoToast.showPushNotificationClicked(
        message,
        onTap: () => FiicoRoute.changeTab(_context, TabOption.notifications),
      );
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

  void suscribe(String topic) async {
    await FirebaseMessaging.instance
        .subscribeToTopic('$topic')
        .catchError((error) {
      print(error.toString());
    }).then((value) {
      print("Correct subscribe");
    });
  }

  void unsuscribe(String topic) async {
    await FirebaseMessaging.instance
        .unsubscribeFromTopic('$topic')
        .catchError((error) {
      print(error.toString());
    }).then((value) {
      print("Correct unsubscribe");
    });
  }
}
