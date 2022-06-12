// ignore_for_file: overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeDebtsMovements implements MovementGroup {
  @override
  final name = FiicoLocale().home;

  @override
  final id = 0;

  @override
  final items = [
    _foodExpenses,
    _rent,
    _homeHipotec,
    _gasService,
    _waterService,
    _lightService,
    _schoolSuplies,
    _internet,
    _admin,
    _school,
    _university,
    _prepaidMedicine,
    _health,
    _gasolina,
    _kinderGarden,
    _pets,
    _babySiter,
    _cleaningService,
    _nurse,
  ];

  // Gastos alimenticions
  static final _foodExpenses = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().feeding,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.food),
    type: MovementType.DEBT.name,
    description: FiicoLocale().feeding,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
    isVariableValue: true,
  );

  // Arriendo
  static final _rent = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().rent,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.home),
    type: MovementType.DEBT.name,
    description: FiicoLocale().rent,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _homeHipotec = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().mortgagePayment,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.homePlus),
    type: MovementType.DEBT.name,
    description: FiicoLocale().mortgagePayment,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _gasService = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().gasService,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.gasCylinder),
    type: MovementType.DEBT.name,
    description: FiicoLocale().gasService,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
    isVariableValue: true,
  );

  static final _waterService = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().waterService,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.water),
    type: MovementType.DEBT.name,
    description: FiicoLocale().waterService,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
    isVariableValue: true,
  );

  static final _lightService = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().lightService,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.lightbulb),
    type: MovementType.DEBT.name,
    description: FiicoLocale().lightService,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
    isVariableValue: true,
  );

  static final _schoolSuplies = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().schoolSupplies,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.school),
    type: MovementType.DEBT.name,
    description: FiicoLocale().schoolSupplies,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _internet = Movement(
    id: const Uuid().v1(),
    name: 'Internet',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.wifi),
    type: MovementType.DEBT.name,
    description: 'Internet',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _admin = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().management,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.admin_panel_settings),
    type: MovementType.DEBT.name,
    description: FiicoLocale().management,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _school = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().school,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(FontAwesomeIcons.school),
    type: MovementType.DEBT.name,
    description: FiicoLocale().school,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _university = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().university,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(FontAwesomeIcons.buildingColumns),
    type: MovementType.DEBT.name,
    description: FiicoLocale().university,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _prepaidMedicine = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().prepaidMedicine,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.medicalBag),
    type: MovementType.DEBT.name,
    description: FiicoLocale().prepaidMedicine,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _health = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().health,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.healing),
    type: MovementType.DEBT.name,
    description: FiicoLocale().health,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _gasolina = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().gasoline,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.local_gas_station),
    type: MovementType.DEBT.name,
    description: FiicoLocale().gasoline,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
    isVariableValue: true,
  );

  static final _kinderGarden = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().kindergarden,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.child_care),
    type: MovementType.DEBT.name,
    description: FiicoLocale().kindergarden,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _pets = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().pets,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.pets),
    type: MovementType.DEBT.name,
    description: FiicoLocale().pets,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _babySiter = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().babySister,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.baby_changing_station),
    type: MovementType.DEBT.name,
    description: FiicoLocale().babySister,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _cleaningService = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().cleaning,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.cleaning_services),
    type: MovementType.DEBT.name,
    description: FiicoLocale().cleaning,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _nurse = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().nurse,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.motherNurse),
    type: MovementType.DEBT.name,
    description: FiicoLocale().nurse,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  @override
  MovementType get type => MovementType.DEBT;
}
