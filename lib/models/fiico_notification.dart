// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum FiicoNotificationType {
  DEFAULT,
  INVITE,
  ALERT_DEBT,
  ALERT_ENTRY,
  EDITED,
  BANNER,
  PREMIUM,
  HELPCENTER,
}

class FiicoNotification extends Equatable {
  final String? id;
  final String? message;
  final String? title;
  final String? type;
  final String? senderID;
  final String? receivedID;
  final String? budgetID;
  final bool? readed;
  final Timestamp? date;
  final String? imageUrl;
  final bool? clickeable;

  const FiicoNotification({
    this.id,
    this.message,
    this.title,
    this.type,
    this.senderID,
    this.receivedID,
    this.budgetID,
    this.readed,
    this.imageUrl,
    this.clickeable,
    this.date,
  });

  factory FiicoNotification.fromJson(Map<String, dynamic>? json) {
    return FiicoNotification(
      id: json?['id'],
      message: json?['message'],
      title: json?['title'],
      type: json?['type'],
      senderID: json?['senderID'],
      receivedID: json?['receivedID'],
      clickeable: json?['clickeable'],
      budgetID: json?['budgetID'],
      imageUrl: json?['imageUrl'],
      readed: json?['readed'],
      date: json?['date'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'message': message ?? '',
      'title': title ?? '',
      'senderID': senderID ?? '',
      'receivedID': receivedID ?? '',
      'clickeable': clickeable ?? false,
      'budgetID': budgetID ?? '',
      'imageUrl': imageUrl ?? '',
      'readed': readed ?? false,
      'date': date ?? Timestamp.now(),
      'type': type ?? '',
    };
  }

  // Generic functions
  FiicoNotificationType getType() {
    switch (type) {
      case 'INVITE':
        return FiicoNotificationType.INVITE;
      case 'BANNER':
        return FiicoNotificationType.BANNER;
      case 'EDITED':
        return FiicoNotificationType.EDITED;
      case 'PREMIUM':
        return FiicoNotificationType.PREMIUM;
      case 'HELPCENTER':
        return FiicoNotificationType.HELPCENTER;
      default:
        return FiicoNotificationType.DEFAULT;
    }
  }

  String getAcceptButtonText() {
    switch (getType()) {
      case FiicoNotificationType.INVITE:
        return 'Ver invitación';
      default:
        return 'Aceptar';
    }
  }

  String getCreateDate() {
    return date?.toDate().toDateFormat1() ?? '';
  }

  Color getBorderColor() {
    return getType() == FiicoNotificationType.BANNER
        ? FiicoColors.white
        : readed ?? false
            ? FiicoColors.grayNeutral
            : FiicoColors.purpleDark;
  }

  @override
  List<Object?> get props => [id, readed, type, message, date];
}
