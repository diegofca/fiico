import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmailValidatorModel {
  final String email;

  const EmailValidatorModel(this.email);

  bool get isValid => _isValidEmail();
  bool get isEmpty => email.isEmpty;
  bool get isError => !_isValidEmail() && !isEmpty;

  Icon get getStatusIcon => Icon(
        isEmpty
            ? MdiIcons.email
            : isError
                ? MdiIcons.emailLock
                : MdiIcons.emailCheck,
        color: getStatusColor,
      );

  Icon? get getRigthStatusIcon => Icon(
        isEmpty
            ? null
            : isError
                ? MdiIcons.close
                : MdiIcons.checkBold,
        color: getStatusColor,
      );

  Color get getStatusColor =>
      isEmpty || isValid ? FiicoColors.purpleDark : FiicoColors.pinkRed;

  bool _isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
}
