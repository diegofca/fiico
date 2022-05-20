// ignore_for_file: constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/mark_movement.dart';
import 'package:control/network/firestore_path.dart';
import 'package:flutter/material.dart';

enum MovementType { ENTRY, DEBT, SAFE }
enum MovementPaymentType { PENDING, PAYED }

class Movement {
  final String? id;
  final String? name;
  final num? value;
  final Timestamp? createdAt;
  final List<int>? recurrencyAt;
  final FiicoIcon? icon;
  final String? type;
  final String? description;
  final String? typeDescription;
  final String? currency;
  final String? budgetName;
  final List<String>? tags;
  final FiicoAlert? alert;
  final bool isAddedWithBudget;
  final String? paymentStatus;
  final List<MarkMovement> markHistory;
  final List<Timestamp>? recurrencyDates;
  final bool? isVariableValue;

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
    required this.alert,
    required this.paymentStatus,
    this.tags = const [],
    this.isAddedWithBudget = false,
    this.markHistory = const [],
    this.recurrencyDates = const [],
    this.isVariableValue = false,
  });

  factory Movement.fromJson(Map<String, dynamic>? json) {
    return Movement(
      id: json?['id'],
      name: json?['name'] ?? '',
      value: json?['value'] ?? 0,
      createdAt: json?['createdAt'] ?? Timestamp.now(),
      recurrencyAt: List.castFrom(json?['recurrencyAt'] ?? []),
      type: json?['type'] ?? '',
      description: json?['description'],
      typeDescription: json?['typeDescription'] ?? '',
      currency: json?['currency'] ?? '',
      budgetName: json?['budgetName'] ?? '',
      paymentStatus: json?['paymentStatus'] ?? 'Pending',
      icon: FiicoIcon.fromJson(json?['icon']),
      alert: FiicoAlert.fromJson(json?['alert']),
      tags: List.castFrom(json?['tags']),
      markHistory: MarkMovement.toList(json),
      recurrencyDates: List.castFrom(json?['recurrencyDates']),
      isVariableValue: json?['isVariableValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'createdAt': createdAt,
      'recurrencyAt': recurrencyAt?..sort(),
      'type': type,
      'description': description,
      'typeDescription': typeDescription,
      'currency': currency,
      'budgetName': budgetName,
      'paymentStatus': paymentStatus,
      'icon': icon?.toJson(),
      'alert': alert?.toJson(),
      'tags': tags,
      'markHistory': markHistory.map((e) => e.toJson()).toList(),
      'recurrencyDates': recurrencyDates,
      'isVariableValue': isVariableValue,
    };
  }

  Movement copyWith({
    String? id,
    String? name,
    num? value,
    Timestamp? createdAt,
    List<int>? recurrencyAt,
    FiicoIcon? icon,
    String? type,
    String? description,
    String? typeDescription,
    String? currency,
    String? budgetName,
    List<String>? tags,
    FiicoAlert? alert,
    bool isAddedWithBudget = false,
    String? paymentStatus,
    List<MarkMovement>? markHistory,
    List<Timestamp>? recurrencyDates,
    bool? isVariableValue,
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
      currency: currency ?? this.currency,
      budgetName: budgetName ?? this.budgetName,
      alert: alert ?? this.alert,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      recurrencyDates: recurrencyDates ?? this.recurrencyDates,
      isAddedWithBudget: isAddedWithBudget,
      markHistory: markHistory ?? this.markHistory,
      isVariableValue: isVariableValue ?? this.isVariableValue,
      tags: tags ?? this.tags,
    );
  }

  static List<Movement> toList(Map<String, dynamic>? json) {
    List<Movement> movements = [];
    json?[Firestore.movementsField]?.forEach((move) {
      movements.add(Movement.fromJson(move));
    });
    return movements;
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
        return FiicoLocale().income;
      case MovementType.DEBT:
        return FiicoLocale().outcome;
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
        return FiicoLocale().averageDayOfAdmission;
      case MovementType.DEBT:
        return FiicoLocale().averageDayOfPayment;
      default:
        return '';
    }
  }

  String getAlertDay() {
    final day = alert?.day ?? recurrencyAt?.first ?? 1;
    final recurrencyDate =
        DateTime(DateTime.now().year, DateTime.now().month, day);
    return recurrencyDate.toDateFormat1();
  }

  String getAlertDates() {
    final dates =
        alert?.dates ?? recurrencyDates?.map((e) => e.toDate()).toList() ?? [];
    if (dates.isEmpty) {
      return FiicoLocale().withoutDate;
    }
    if (dates.length == 1) {
      return dates.first.toDateFormat1();
    }
    return '${dates.length} ${FiicoLocale().dates}';
  }

  String getRecurrencyDate() {
    final days = recurrencyAt?.map((e) => e.toString());
    if (days == null || days.isEmpty) {
      if (recurrencyDates?.isNotEmpty ?? false) {
        return recurrencyDates?.length == 1
            ? recurrencyDates?.first.toDate().toDateFormat1() ?? ''
            : '${recurrencyDates?.length} ${FiicoLocale().dates}';
      }
      return '';
    }

    switch (getType()) {
      case MovementType.ENTRY:
        return '${days.join(',').toString()} ${FiicoLocale().everyOfMonth}';
      case MovementType.DEBT:
        return '${days.join(',').toString()} ${FiicoLocale().everyOfMonth}';
      default:
        return '';
    }
  }

  String getRecurrencyDateDescription() {
    switch (getType()) {
      case MovementType.ENTRY:
        return '${FiicoLocale().income}: ${getRecurrencyDate()}';
      case MovementType.DEBT:
        return '${FiicoLocale().timleyPayment}: ${getRecurrencyDate()}';
      default:
        return '';
    }
  }

  Color getBellColor() {
    if (alert?.day == null) {
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
            ? FiicoLocale().pending
            : FiicoLocale().received;
      case MovementType.DEBT:
        return getPaymentType() == MovementPaymentType.PENDING
            ? FiicoLocale().pending
            : FiicoLocale().paid;
      default:
        return FiicoLocale().received;
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

  bool isCompleteByCreate() {
    final nameContained = name?.isNotEmpty ?? false;
    final valueContained = value != null && value != 0;
    final dayToPending =
        recurrencyAt != null || (recurrencyDates?.isNotEmpty ?? false);
    final currencyContained = currency?.isNotEmpty ?? false;
    return nameContained && valueContained && currencyContained & dayToPending;
  }
}
