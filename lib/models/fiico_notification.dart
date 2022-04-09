import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:equatable/equatable.dart';

class FiicoNotification extends Equatable {
  final String? id;
  final String? message;
  final String? title;
  final String? type;
  final String? senderID;
  final String? recieverID;
  final bool? readed;
  final Timestamp? date;

  const FiicoNotification({
    this.id,
    this.message,
    this.title,
    this.type,
    this.senderID,
    this.recieverID,
    this.readed,
    this.date,
  });

  factory FiicoNotification.fromJson(Map<String, dynamic>? json) {
    return FiicoNotification(
      id: json?['id'],
      message: json?['message'],
      title: json?['title'],
      type: json?['type'],
      senderID: json?['senderId'],
      recieverID: json?['receiverId'],
      readed: json?['readed'],
      date: json?['date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'message': message ?? '',
      'title': title ?? '',
      'type': type ?? '',
      'senderID': senderID ?? '',
      'recieverID': recieverID ?? '',
      'readed': readed ?? false,
      'date': date ?? Timestamp.now(),
    };
  }

  String getCreateDate() {
    return date?.toDate().toDateFormat1() ?? '';
  }

  @override
  List<Object?> get props => [id, readed, message, date];
}
