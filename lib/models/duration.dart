// ignore_for_file: constant_identifier_names

enum BudgetDurationType { MONTH, THREE_MONTH, SIX_MONTH, ANNUAL, CUSTOM }

class BudgetDuration {
  final String name;
  final int value;

  BudgetDuration(this.name, this.value);

  BudgetDuration.month({this.name = 'Un mes', this.value = 0});
  BudgetDuration.threeMonths({this.name = 'Tres meses', this.value = 1});
  BudgetDuration.sixMonths({this.name = 'Seis meses', this.value = 2});
  BudgetDuration.annual({this.name = 'Anual', this.value = 3});
  BudgetDuration.custom({this.name = 'Personalizado', this.value = 4});
}
