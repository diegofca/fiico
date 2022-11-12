import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/network/firestore_path.dart';
import 'package:collection/collection.dart';

abstract class NotificationsRepositoryAbs {
  Stream<List<FiicoNotification>> notifications(String? userID);
  Future<FiicoNotification> getNotifications(FiicoNotification? notification);
  Future<void> readNotification(FiicoNotification? notification);
  Future<void> sendNotifications(FiicoNotification? notification);
  Future<Budget> getBudget(String? budgetID);
}

class NotificationsRepository extends NotificationsRepositoryAbs {
  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  @override
  Stream<List<FiicoNotification>> notifications(String? userID) {
    return usersollections
        .doc(userID)
        .collection(Firestore.notificationssPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => FiicoNotification.fromJson(doc.data()))
          .sorted((a, b) => b.date!.toDate().compareTo(a.date!.toDate()))
          .toList();
    });
  }

  //Generic ----------------------------------------------------------
  @override
  Future<FiicoNotification> getNotifications(
      FiicoNotification? notification) async {
    return usersollections
        .doc(notification?.receivedID)
        .collection(Firestore.notificationssPath)
        .doc(notification?.id)
        .snapshots()
        .map((snapshot) {
      return FiicoNotification.fromJson(snapshot.data());
    }).first;
  }

  @override
  Future<void> sendNotifications(FiicoNotification? notification) async {
    return usersollections
        .doc(notification?.receivedID)
        .collection(Firestore.notificationssPath)
        .doc(notification?.id)
        .set(notification!.toJson());
  }

  @override
  Future<void> readNotification(FiicoNotification? notification) async {
    return usersollections
        .doc(notification?.receivedID)
        .collection(Firestore.notificationssPath)
        .doc(notification?.id)
        .update({Firestore.readedField: true});
  }

  @override
  Future<Budget> getBudget(String? budgetID) async {
    final user = await Preferences.get.getUser();
    return usersollections
        .doc(user?.id)
        .collection(Firestore.budgetsPath)
        .doc(budgetID)
        .snapshots()
        .map((snapshot) {
      return Budget.fromJson(snapshot.data());
    }).first;
  }
}
