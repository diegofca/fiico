import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/network/firestore_path.dart';
import 'package:collection/collection.dart';

abstract class NotificationsRepositoryAbs {
  Stream<List<FiicoNotification>> notifications(String? userID);
  Future<FiicoNotification> getNotifications(String? userID);
  Future<void> updateNotification(FiicoNotification notification);
}

class NotificationsRepository extends NotificationsRepositoryAbs {
  final budgetCollections =
      FirebaseFirestore.instance.collection(Firestore.notificationssPath);

  @override
  Stream<List<FiicoNotification>> notifications(String? userID) {
    return budgetCollections
        .where('receiverId', isEqualTo: userID)
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
  Future<FiicoNotification> getNotifications(String? userID) async {
    return budgetCollections.doc(userID).snapshots().map((snapshot) {
      return FiicoNotification.fromJson(snapshot.data());
    }).first;
  }

  @override
  Future<void> updateNotification(FiicoNotification notification) async {
    return budgetCollections.doc(notification.id).update({
      'readed': true,
    });
  }
}
