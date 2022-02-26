class Recurrency {
  final String name;
  final int value;

  Recurrency(this.name, this.value);

  Recurrency.week({this.name = 'Semanal', this.value = 0});
  Recurrency.biweekly({this.name = 'Quincenal', this.value = 1});
  Recurrency.month({this.name = 'Mensual', this.value = 2});
  Recurrency.annual({this.name = 'Anual', this.value = 3});
}
