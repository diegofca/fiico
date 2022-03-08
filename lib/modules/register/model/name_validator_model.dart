class NameValidatorModel {
  final String name;

  const NameValidatorModel(this.name);

  bool get isValid => _isValidName();
  bool get isEmpty => name.isEmpty;
  bool get isError => !_isValidName() && !isEmpty;

  bool _isValidName() {
    return name.length > 2;
  }
}
