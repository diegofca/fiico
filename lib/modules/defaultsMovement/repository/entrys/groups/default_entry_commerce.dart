// ignore_for_file: overridden_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class CommercelEntryMovements implements MovementGroup {
  @override
  final name = FiicoLocale().commercial;

  @override
  final id = 1;

  @override
  final items = [
    _store,
    _commerce,
  ];

  // Arriendo
  static final _store = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().store,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.store),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().store,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Arriendo
  static final _commerce = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().business,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(Icons.work),
    type: MovementType.ENTRY.name,
    description: FiicoLocale().business,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  @override
  MovementType get type => MovementType.ENTRY;
}
