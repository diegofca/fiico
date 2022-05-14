// ignore_for_file: constant_identifier_names

import 'package:control/helpers/manager/localizable_manager.dart';

enum BudgetCycleType { TWO_WEEKS, MONTH, ANNUAL }

class BudgetCycle {
  final String name;
  final int value;

  BudgetCycle(this.name, this.value);

  BudgetCycle.twoWeeks({this.name = '', this.value = 0});
  BudgetCycle.month({this.name = '', this.value = 1});
  BudgetCycle.annual({this.name = '', this.value = 2});

  factory BudgetCycle.from({required int cycle}) {
    switch (cycle) {
      case 0:
        return BudgetCycle.twoWeeks(name: FiicoLocale.biweekly);
      case 1:
        return BudgetCycle.month(name: FiicoLocale.monthly);
      default:
        return BudgetCycle.annual(name: FiicoLocale.annual);
    }
  }
}
