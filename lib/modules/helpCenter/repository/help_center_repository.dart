import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/helpCenterConversation.dart';
import 'package:control/models/helpCenterMessage.dart';
import 'package:control/network/firestore_path.dart';

abstract class HelpCenterRepositoryAbs {
  Stream<List<HelpCenterConversation>> conversation(String? userID);
  Stream<List<HelpCenterMessage>> messsages(
      String? conversationID, String? userID);
  Future<void> newMessage(
      HelpCenterMessage message, String? conversationID, String? userID);
}

class HelpCenterRepository extends HelpCenterRepositoryAbs {
  final conversationsCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  final messagesCollections =
      FirebaseFirestore.instance.collection(Firestore.usersPath);

  @override
  Stream<List<HelpCenterConversation>> conversation(String? userID) {
    return conversationsCollections
        .doc(userID)
        .collection(Firestore.helpCenterPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => HelpCenterConversation.fromJson(doc.id, doc.data()))
          .toList();
    });
  }

  @override
  Stream<List<HelpCenterMessage>> messsages(
    String? conversationID,
    String? userID,
  ) {
    return messagesCollections
        .doc(userID)
        .collection(Firestore.helpCenterPath)
        .doc(conversationID)
        .collection(Firestore.helpCenterMessagesPath)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => HelpCenterMessage.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<void> newMessage(
    HelpCenterMessage message,
    String? conversationID,
    String? userID,
  ) {
    return messagesCollections
        .doc(userID)
        .collection(Firestore.helpCenterPath)
        .doc(conversationID)
        .collection(Firestore.helpCenterMessagesPath)
        .add(message.toJson());
  }
}
