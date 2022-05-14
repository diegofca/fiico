// ignore_for_file: overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class HomeDebtsMovements implements MovementGroup {
  @override
  final name = 'Hogar';

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
    name: 'Alimentación',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.food),
    type: MovementType.DEBT.name,
    description: 'Saldo de gastos alimenticios',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Arriendo
  static final _rent = Movement(
    id: const Uuid().v1(),
    name: 'Arriendo',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.home),
    type: MovementType.DEBT.name,
    description: 'Saldo de arriendo',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _homeHipotec = Movement(
    id: const Uuid().v1(),
    name: 'Cuota hipotecaria',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.homePlus),
    type: MovementType.DEBT.name,
    description: 'Saldo de cuota de vivienda',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _gasService = Movement(
    id: const Uuid().v1(),
    name: 'Servicio de gas',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.gasCylinder),
    type: MovementType.DEBT.name,
    description: 'Saldo de servicio de gas',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _waterService = Movement(
    id: const Uuid().v1(),
    name: 'Servicio de agua',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.water),
    type: MovementType.DEBT.name,
    description: 'Saldo de servicio de agua',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _lightService = Movement(
    id: const Uuid().v1(),
    name: 'Servicio de luz',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.lightbulb),
    type: MovementType.DEBT.name,
    description: 'Saldo de servicio de luz',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _schoolSuplies = Movement(
    id: const Uuid().v1(),
    name: 'Utiles escolares',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.school),
    type: MovementType.DEBT.name,
    description: 'Saldo de Utiles escolares',
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
    description: 'Saldo de Utiles escolares',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _admin = Movement(
    id: const Uuid().v1(),
    name: 'Administración',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.admin_panel_settings),
    type: MovementType.DEBT.name,
    description: 'Saldo de administración',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _school = Movement(
    id: const Uuid().v1(),
    name: 'Escuela',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(FontAwesomeIcons.school),
    type: MovementType.DEBT.name,
    description: 'Saldo de escuela',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _university = Movement(
    id: const Uuid().v1(),
    name: 'Universidad',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(FontAwesomeIcons.university),
    type: MovementType.DEBT.name,
    description: 'Saldo de universidad',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _prepaidMedicine = Movement(
    id: const Uuid().v1(),
    name: 'Medicina prepagada',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.medicalBag),
    type: MovementType.DEBT.name,
    description: 'Saldo de medicina prepagada',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _health = Movement(
    id: const Uuid().v1(),
    name: 'Salud',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.healing),
    type: MovementType.DEBT.name,
    description: 'Saldo de cuota de salud obligatoria',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _gasolina = Movement(
    id: const Uuid().v1(),
    name: 'Gasolina',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.local_gas_station),
    type: MovementType.DEBT.name,
    description: 'Saldo de gasolina',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _kinderGarden = Movement(
    id: const Uuid().v1(),
    name: 'Guarderia',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.child_care),
    type: MovementType.DEBT.name,
    description: 'Saldo de guarderia',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _pets = Movement(
    id: const Uuid().v1(),
    name: 'Mascotas',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.pets),
    type: MovementType.DEBT.name,
    description: 'Saldo de mascotas',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _babySiter = Movement(
    id: const Uuid().v1(),
    name: 'Niñera',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.baby_changing_station),
    type: MovementType.DEBT.name,
    description: 'Saldo de niñera',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _cleaningService = Movement(
    id: const Uuid().v1(),
    name: 'Limpieza',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.cleaning_services),
    type: MovementType.DEBT.name,
    description: 'Saldo de limpieza',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _nurse = Movement(
    id: const Uuid().v1(),
    name: 'Enfermera',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.motherNurse),
    type: MovementType.DEBT.name,
    description: 'Saldo de enfermera',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  @override
  MovementType get type => MovementType.DEBT;
}
