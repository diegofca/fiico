// ignore_for_file: constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/network/firestore_path.dart';
import 'package:flutter/material.dart';

enum MovementType { ENTRY, DEBT, SAFE }
enum MovementPaymentType { PENDING, PAYED }

class Movement {
  final String? id;
  final String? name;
  final num? value;
  final Timestamp? createdAt;
  final Timestamp? recurrencyAt;
  final FiicoIcon? icon;
  final String? type;
  final String? description;
  final String? typeDescription;
  final String? recurrency;
  final String? currency;
  final String? budgetName;
  final List<String> tags;
  final FiicoAlert? alert;
  final bool isAddedWithBudget;
  final String? paymentStatus;

  Movement({
    required this.id,
    required this.name,
    required this.value,
    required this.createdAt,
    required this.recurrencyAt,
    required this.icon,
    required this.type,
    required this.description,
    required this.typeDescription,
    required this.currency,
    required this.budgetName,
    required this.recurrency,
    required this.alert,
    required this.paymentStatus,
    this.tags = const [],
    this.isAddedWithBudget = false,
  });

  factory Movement.fromJson(Map<String, dynamic>? json) {
    return Movement(
      id: json?['id'],
      name: json?['name'] ?? '',
      value: json?['value'] ?? 0,
      createdAt: json?['createdAt'] ?? Timestamp.now(),
      recurrencyAt: json?['recurrencyAt'] ?? Timestamp.now(),
      type: json?['type'] ?? '',
      description: json?['description'],
      typeDescription: json?['typeDescription'] ?? '',
      currency: json?['currency'] ?? '',
      budgetName: json?['budgetName'] ?? '',
      recurrency: json?['recurrency'] ?? '',
      paymentStatus: json?['paymentStatus'] ?? 'Pending',
      icon: FiicoIcon.fromJson(json?['icon']),
      alert: FiicoAlert.fromJson(json?['alert']),
      tags: List.castFrom(json?['tags']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'createdAt': createdAt,
      'recurrencyAt': recurrencyAt,
      'type': type,
      'description': description,
      'typeDescription': typeDescription,
      'currency': currency,
      'budgetName': budgetName,
      'recurrency': recurrency,
      'paymentStatus': paymentStatus,
      'icon': icon?.toJson(),
      'alert': alert?.toJson(),
      'tags': tags,
    };
  }

  Movement copyWith({
    String? id,
    String? name,
    num? value,
    Timestamp? createdAt,
    Timestamp? recurrencyAt,
    FiicoIcon? icon,
    String? type,
    String? description,
    String? typeDescription,
    String? recurrency,
    String? currency,
    String? budgetName,
    List<String> tags = const [],
    FiicoAlert? alert,
    bool isAddedWithBudget = false,
    String? paymentStatus,
  }) {
    return Movement(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
      recurrencyAt: recurrencyAt ?? this.recurrencyAt,
      icon: icon ?? this.icon,
      type: type ?? this.type,
      description: description ?? this.description,
      typeDescription: typeDescription ?? this.typeDescription,
      recurrency: recurrency ?? this.recurrency,
      currency: currency ?? this.currency,
      budgetName: budgetName ?? this.budgetName,
      alert: alert ?? this.alert,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      isAddedWithBudget: isAddedWithBudget,
      tags: tags,
    );
  }

  /// Functions classs
  MovementType getType() {
    switch (type) {
      case 'ENTRY':
        return MovementType.ENTRY;
      case 'DEBT':
        return MovementType.DEBT;
      default:
        return MovementType.SAFE;
    }
  }

  MovementPaymentType getPaymentType() {
    switch (paymentStatus) {
      case 'Pending':
        return MovementPaymentType.PENDING;
      default:
        return MovementPaymentType.PAYED;
    }
  }

  Widget getIcon() {
    switch (getType()) {
      case MovementType.ENTRY:
        return FiicoImageNetwork.entry(iconData: icon?.getIcon());
      case MovementType.DEBT:
        return FiicoImageNetwork.debt(iconData: icon?.getIcon());
      default:
        return FiicoImageNetwork.debt(iconData: icon?.getIcon());
    }
  }

  String getTypeDescription() {
    switch (getType()) {
      case MovementType.ENTRY:
        return 'Income';
      case MovementType.DEBT:
        return 'OutCome';
      default:
        return 'Safe';
    }
  }

  Color getTypeColor() {
    switch (getType()) {
      case MovementType.ENTRY:
        return FiicoColors.greenNeutral;
      case MovementType.DEBT:
        return FiicoColors.pinkRed;
      default:
        return FiicoColors.grayDark;
    }
  }

  String getDateTitleText() {
    switch (getType()) {
      case MovementType.ENTRY:
        return 'Fecha de ingreso oportuno';
      case MovementType.DEBT:
        return 'Fecha de pago oportuno';
      default:
        return 'Fecha';
    }
  }

  String getAlertDate() {
    return alert?.date?.toDate().toDateFormat1() ?? '';
  }

  String getRecurrencyDate() {
    return recurrencyAt?.toDate().toDateFormat2() ?? '';
  }

  Color getBellColor() {
    if (alert?.date == null) {
      return FiicoColors.grayNeutral;
    }
    if (alert?.isIntensive() ?? false) {
      return FiicoColors.pinkRed;
    }
    return FiicoColors.gold;
  }

  num? getValue() {
    switch (getType()) {
      case MovementType.DEBT:
        return (value ?? 0) * -1;
      default:
        return value;
    }
  }

  String getPaymentStatusText() {
    switch (getType()) {
      case MovementType.ENTRY:
        return getPaymentType() == MovementPaymentType.PENDING
            ? 'Pendiente'
            : 'Recibido';
      case MovementType.DEBT:
        return getPaymentType() == MovementPaymentType.PENDING
            ? 'Pendiente'
            : 'Pagado';
      default:
        return 'Recibido';
    }
  }

  Color getPaymentStatusColor() {
    return getPaymentType() == MovementPaymentType.PENDING
        ? FiicoColors.pink
        : FiicoColors.greenNeutral;
  }

  bool isPaymentPendingState() {
    final isPaymentPeding = getPaymentType() == MovementPaymentType.PENDING;
    return isPaymentPeding && !isAddedWithBudget;
  }

  static List<Movement> toList(Map<String, dynamic>? json) {
    List<Movement> movements = [];
    json?[Firestore.movementsField]?.forEach((move) {
      movements.add(Movement.fromJson(move));
    });
    return movements;
  }

  bool isCompleteByCreate() {
    final nameContained = name?.isNotEmpty ?? false;
    final valueContained = value != null && value != 0;
    final currencyContained = currency?.isNotEmpty ?? false;
    return nameContained && valueContained && currencyContained;
  }
}
