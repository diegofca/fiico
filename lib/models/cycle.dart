// ignore_for_file: constant_identifier_names

enum BudgetCycleType { TWO_WEEKS, MONTH, ANNUAL }

class BudgetCycle {
  final String name;
  final int value;

  BudgetCycle(this.name, this.value);

  BudgetCycle.twoWeeks({this.name = 'Quincenal', this.value = 0});
  BudgetCycle.month({this.name = 'Mensual', this.value = 1});
  BudgetCycle.annual({this.name = 'Anual', this.value = 2});

  factory BudgetCycle.from({required int cycle}) {
    switch (cycle) {
      case 0:
        return BudgetCycle.twoWeeks();
      case 1:
        return BudgetCycle.month();
      default:
        return BudgetCycle.annual();
    }
  }
}
