// ignore_for_file: overridden_fields

import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/defaultsMovement/repository/debts/groups/default_debts_entretainment.dart';
import 'package:control/modules/defaultsMovement/repository/debts/groups/default_debts_home_list.dart';
import 'package:control/modules/defaultsMovement/repository/debts/groups/default_debts_personal_list.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';

class DebtsMovements implements MovementsList {
  @override
  final name = FiicoLocale().outcomes;

  @override
  final items = [
    HomeDebtsMovements(),
    PersonalDebtsMovements(),
    EntretaimentDebtsMovements()
  ];
}
