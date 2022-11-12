import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LastNameValidatorModel {
  final String lastName;

  const LastNameValidatorModel(this.lastName);

  bool get isValid => _isValidName();
  bool get isEmpty => lastName.isEmpty;
  bool get isError => !_isValidName() && !isEmpty;

  Icon get getStatusIcon => Icon(
        MdiIcons.faceManProfile,
        color: getStatusColor,
      );

  Color get getStatusColor =>
      isEmpty || isValid ? FiicoColors.purpleDark : FiicoColors.pinkRed;

  bool _isValidName() {
    return lastName.length > 2;
  }
}
