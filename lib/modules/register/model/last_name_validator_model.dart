class LastNameValidatorModel {
  final String lastName;

  const LastNameValidatorModel(this.lastName);

  bool get isValid => _isValidName();
  bool get isEmpty => lastName.isEmpty;
  bool get isError => !_isValidName() && !isEmpty;

  bool _isValidName() {
    return lastName.length > 2;
  }
}
