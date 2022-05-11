import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class EntryMovements extends Movements {
  static final items = [
    _salary,
  ];

  // Tarjeta de credito default
  static final _salary = Movement(
    id: const Uuid().v1(),
    name: 'Salario',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: [30],
    icon: FiicoIcon(
      codePoint: MdiIcons.cash.codePoint,
      fontFamily: MdiIcons.cash.fontFamily,
      fontPackage: MdiIcons.cash.fontPackage,
    ),
    type: MovementType.ENTRY.name,
    description: 'Ingreso salarial',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );
}
