// ignore_for_file: overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class PersonalDebtsMovements implements MovementGroup {
  @override
  final name = 'Personal';

  @override
  final id = 1;

  @override
  MovementType get type => MovementType.DEBT;

  @override
  final items = [
    _creditCard,
    _car,
    _motorcycle,
    _travel,
    _telephone,
    _cloting,
    _commerce,
    _gym,
    _drugs
  ];

  // Tarjeta de credito default
  static final _creditCard = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().creditCard,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.creditCard),
    type: MovementType.DEBT.name,
    description: FiicoLocale().creditCard,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Auto default
  static final _car = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().car,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.car),
    type: MovementType.DEBT.name,
    description: FiicoLocale().car,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // viaje default
  static final _travel = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().travel,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.airplanemode_active),
    type: MovementType.DEBT.name,
    description: FiicoLocale().travel,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // celular default
  static final _telephone = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().cellphone,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.cellphone),
    type: MovementType.DEBT.name,
    description: FiicoLocale().cellphone,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _cloting = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().clothing,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.shoeSneaker),
    type: MovementType.DEBT.name,
    description: FiicoLocale().clothing,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _commerce = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().business,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.work),
    type: MovementType.DEBT.name,
    description: FiicoLocale().business,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _motorcycle = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().motorcycle,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.motorcycle),
    type: MovementType.DEBT.name,
    description: FiicoLocale().motorcycle,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _gym = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().gym,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.sports_gymnastics),
    type: MovementType.DEBT.name,
    description: FiicoLocale().gym,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _drugs = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().medicines,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.medication_liquid),
    type: MovementType.DEBT.name,
    description: FiicoLocale().medicines,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );
}
