// ignore_for_file: constant_identifier_names

enum BudgetCycleType { WEEK, TWO_WEEKS, MONTH, THREE_MONTH, SIX_MONTH, ANNUAL }

class BudgetCycle {
  final String name;
  final int value;

  BudgetCycle(this.name, this.value);

  BudgetCycle.week({this.name = 'Semanal', this.value = 0});
  BudgetCycle.twoWeeks({this.name = 'Dos Semanas', this.value = 1});
  BudgetCycle.month({this.name = 'Un mes', this.value = 2});
  BudgetCycle.threeMonths({this.name = 'Tres meses', this.value = 3});
  BudgetCycle.sixMonths({this.name = 'Seis meses', this.value = 4});
  BudgetCycle.annual({this.name = 'Anual', this.value = 5});

  factory BudgetCycle.from({required int cycle}) {
    switch (cycle) {
      case 0:
        return BudgetCycle.week();
      case 1:
        return BudgetCycle.twoWeeks();
      case 2:
        return BudgetCycle.month();
      case 3:
        return BudgetCycle.threeMonths();
      case 4:
        return BudgetCycle.sixMonths();
      default:
        return BudgetCycle.annual();
    }
  }
}
