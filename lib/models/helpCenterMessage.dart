// ignore_for_file: file_names

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';

class HelpCenterMessage {
  final String? message;
  final Timestamp? createdAt;
  final bool? isUserSender;
  final String? type;

  HelpCenterMessage({
    this.message,
    this.createdAt,
    this.isUserSender,
    this.type = 'text',
  });

  HelpCenterMessage date(Timestamp? date) {
    return HelpCenterMessage(
      createdAt: date,
    );
  }

  factory HelpCenterMessage.fromJson(Map<String, dynamic>? json) {
    return HelpCenterMessage(
      message: json?['message'],
      createdAt: json?['createdAt'],
      isUserSender: json?['isUserSender'],
      type: json?['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'createdAt': createdAt,
      'isUserSender': isUserSender,
      'type': type,
    };
  }

  static List<HelpCenterMessage>? toList(Map<String, dynamic>? json) {
    List<HelpCenterMessage> budgets = [];
    if (json?.containsKey('messages') ?? false) {
      json?['messages']?.forEach((budget) {
        budgets.add(HelpCenterMessage.fromJson(budget));
      });
    }
    return budgets;
  }

  Timestamp sortDate() {
    return Timestamp.fromDate(DateTime(
      createdAt!.toDate().year,
      createdAt!.toDate().month,
      createdAt!.toDate().day,
    ));
  }

  Color getBackgroundColor() {
    return isUserSender ?? false
        ? FiicoColors.pink.withOpacity(0.7)
        : FiicoColors.grayLite;
  }

  Color getTextColor() {
    return isUserSender ?? false ? FiicoColors.white : FiicoColors.grayDark;
  }

  static const String textType = 'text';
  static const String dateType = 'date';
}
