import 'package:cloud_firestore/cloud_firestore.dart';

class InviteFriend {
  final String? id;
  final String? status;
  final String? sendUserId;
  final String? sendUserName;
  final String? receivedUserId;
  final String? requestInviteId;
  final Timestamp? createdAt;

  InviteFriend({
    this.id = '',
    required this.sendUserId,
    required this.sendUserName,
    required this.status,
    required this.receivedUserId,
    required this.createdAt,
    this.requestInviteId = '',
  });

  factory InviteFriend.fromJson(Map<String, dynamic>? json) {
    return InviteFriend(
      id: json?['id'],
      status: json?['status'],
      sendUserId: json?['sendUserId'],
      sendUserName: json?['sendUserName'],
      receivedUserId: json?['receivedUserId'],
      requestInviteId: json?['requestInviteId'],
      createdAt: json?['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'sendUserId': sendUserId,
      'sendUserName': sendUserName,
      'receivedUserId': receivedUserId,
      'requestInviteId': requestInviteId,
      'createdAt': createdAt,
    };
  }
}
