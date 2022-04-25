class Recurrency {
  final String name;
  final int value;

  Recurrency(this.name, this.value);

  Recurrency.unique(
      {this.name = 'Solo una vez por ciclo', this.value = uniqueID});
  Recurrency.multiple(
      {this.name = 'Varias veces por ciclo', this.value = multipleID});

  static const uniqueID = 0;
  static const multipleID = 1;
}
