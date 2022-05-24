// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/helpCenterMessage.dart';

class HelpCenterConversation {
  final String? id;
  final String? status;
  final Timestamp? createdAt;
  final bool? blocked;
  List<HelpCenterMessage>? messages = [];

  HelpCenterConversation({
    this.id,
    this.status,
    this.createdAt,
    this.blocked,
    this.messages = const [],
  });

  void addMessages(List<HelpCenterMessage>? messages) {
    if (messages != null) {
      this.messages = messages;
    }
  }

  factory HelpCenterConversation.fromJson(
      String id, Map<String, dynamic>? json) {
    return HelpCenterConversation(
      id: id,
      status: json?['status'],
      createdAt: json?['createdAt'],
      blocked: json?['blocked'],
      messages: HelpCenterMessage.toList(json) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'createdAt': createdAt,
      'blocked': blocked,
      'messages': messages,
    };
  }

  static const initialStatus = 'initial';
  static const activeStatus = 'active';
  static const pendingStatus = 'pending';
  static const finishStatus = 'finish';
}
