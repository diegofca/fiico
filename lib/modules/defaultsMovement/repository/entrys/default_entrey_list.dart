// ignore_for_file: overridden_fields

import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/repository/entrys/groups/default_entry_commerce.dart';
import 'package:control/modules/defaultsMovement/repository/entrys/groups/default_entry_personal_list.dart';

class EntryMovements implements MovementsList {
  @override
  String name = 'Ingresos';

  @override
  List<MovementGroup> items = [
    PersonalEntryMovements(),
    CommercelEntryMovements(),
  ];
}
