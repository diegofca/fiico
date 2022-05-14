import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/debts/default_debts_list.dart';
import 'package:control/modules/defaultsMovement/repository/entrys/default_entrey_list.dart';

class MovementsList {
  final String name = '';
  final List<MovementGroup> items = [];

  static MovementsList getListBy({required MovementType type}) {
    switch (type) {
      case MovementType.DEBT:
        return DebtsMovements();
      default:
        return EntryMovements();
    }
  }
}

class MovementGroup {
  final String name = '';
  final MovementType type = MovementType.DEBT;
  final int id = 0;
  final List<Movement> items = [];
}
