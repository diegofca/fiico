import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/modules/notifications/repository/notifications_repository.dart';
import 'package:uuid/uuid.dart';

class NotificationsManager {
  static final NotificationsRepository _repository = NotificationsRepository();

  static send() {
    final notification = FiicoNotification(
      id: const Uuid().v1(),
      title: 'hOLA',
      message: 'AMigos',
      senderID: Preferences.get.getID,
      receivedID: 'EsgdHm66JpXAo3ZEONo0Lq1H9U72',
      date: Timestamp.now(),
    );
    _repository.sendNotifications(notification);
  }
}
