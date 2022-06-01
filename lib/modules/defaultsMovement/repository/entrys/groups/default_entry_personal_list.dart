// ignore_for_file: overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class PersonalEntryMovements implements MovementGroup {
  @override
  final name = 'Personal';

  @override
  final id = 0;

  @override
  final items = [_salary, _rent, _allowance, _settlement, _bonus];

  // Tarjeta de credito default
  static final _salary = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().salary,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.cash),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().salary,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Arriendo
  static final _rent = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().rent,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.home),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().rent,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // mesada
  static final _allowance = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().allowance,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.monetization_on),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().allowance,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // mesada
  static final _settlement = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().settlement,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.work_off),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().settlement,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // mesada
  static final _bonus = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().bonus,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.workspace_premium),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().bonus,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  @override
  MovementType get type => MovementType.ENTRY;
}
