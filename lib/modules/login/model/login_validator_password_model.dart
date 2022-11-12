import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PasswordValidatorModel {
  final String password;

  const PasswordValidatorModel(this.password);

  bool get isValid => _isValidPass();
  bool get isEmpty => password.isEmpty;
  bool get isError => !_isValidPass() && !isEmpty;

  Icon get getStatusIcon => Icon(
        isEmpty
            ? MdiIcons.lock
            : isError
                ? MdiIcons.lockOpen
                : MdiIcons.lockCheck,
        color: getStatusColor,
      );

  Color get getStatusColor =>
      isEmpty || isValid ? FiicoColors.purpleDark : FiicoColors.pinkRed;

  bool _isValidPass() {
    return RegExp(
            r'^(?=.*\d)(?=.*[A-Z])(?=.*[,.-_!@#$%^&*()])[A-Za-z0-9_!@#$%^&*(),.?":{}|<>]{8,20}$')
        .hasMatch(password);
  }
}
