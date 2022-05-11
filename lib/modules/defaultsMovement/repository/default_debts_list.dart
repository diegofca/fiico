import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class DebtsMovements extends Movements {
  static final items = [_creditCard, _foodExpenses];

  // Tarjeta de credito default
  static final _creditCard = Movement(
    id: const Uuid().v1(),
    name: 'Tarjeta de credito',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: [1],
    icon: FiicoIcon(
      codePoint: MdiIcons.creditCard.codePoint,
      fontFamily: MdiIcons.creditCard.fontFamily,
      fontPackage: MdiIcons.creditCard.fontPackage,
    ),
    type: MovementType.DEBT.name,
    description: 'Saldo de tarjeta de crédito',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Gastos alimenticions
  static final _foodExpenses = Movement(
    id: const Uuid().v1(),
    name: 'Gastos alimenticios',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: [1],
    icon: FiicoIcon(
      codePoint: MdiIcons.food.codePoint,
      fontFamily: MdiIcons.food.fontFamily,
      fontPackage: MdiIcons.food.fontPackage,
    ),
    type: MovementType.DEBT.name,
    description: 'Gastos alimenticios',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );
}
