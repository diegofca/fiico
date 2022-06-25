import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class DailyDebtsMovements {
  // Gastos Diarios
  static Movement daily(Budget budget) {
    return Movement(
      id: const Uuid().v1(),
      name: FiicoLocale().dailyExpenses,
      value: null,
      createdAt: Timestamp.now(),
      recurrencyAt: null,
      icon: FiicoIcon.fromIcon(MdiIcons.viewDayOutline),
      type: MovementType.DAILY_DEBT.name,
      description: FiicoLocale().dailyExpenses,
      typeDescription: null,
      currency: budget.currency,
      budgetName: budget.name,
      alert: null,
      paymentStatus: 'Payed',
      isDailyDebt: true,
      isVariableValue: false,
    );
  }
}
