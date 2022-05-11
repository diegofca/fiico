import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_debts_list.dart';
import 'package:control/modules/defaultsMovement/repository/default_entrey_list.dart';

class Movements {
  static List<Movement> items(MovementType type) {
    switch (type) {
      case MovementType.DEBT:
        return DebtsMovements.items;
      case MovementType.ENTRY:
        return EntryMovements.items;
      default:
        return [];
    }
  }
}
