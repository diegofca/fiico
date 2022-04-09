import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class FiicoAlertDialog {
  static void showSuccess(
    BuildContext context, {
    String? title,
    String message = '',
    String confirmBtnText = 'Continue',
    VoidCallback? onOkAction,
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      title: title,
      text: '\n\n$message\n',
      confirmBtnText: ' $confirmBtnText ',
      loopAnimation: false,
      backgroundColor: FiicoColors.purpleNeutral,
      confirmBtnColor: FiicoColors.greenNeutral,
      onConfirmBtnTap: () {
        Navigator.of(context).pop();
        onOkAction?.call();
      },
      confirmBtnTextStyle: Style.title.copyWith(
        fontSize: FiicoFontSize.sm,
        color: FiicoColors.white,
      ),
    );
  }

  static void showWarnning(
    BuildContext context, {
    String? title,
    String message = '',
    String confirmBtnText = 'Accept',
    VoidCallback? onOkAction,
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.warning,
      title: title,
      text: '\n\n$message\n',
      confirmBtnText: ' $confirmBtnText ',
      loopAnimation: false,
      backgroundColor: FiicoColors.grayLite,
      confirmBtnColor: FiicoColors.purpleDark,
      onConfirmBtnTap: () {
        Navigator.of(context).pop();
        onOkAction?.call();
      },
      confirmBtnTextStyle: Style.title.copyWith(
        fontSize: FiicoFontSize.sm,
        color: FiicoColors.white,
      ),
    );
  }

  static void showInfo(
    BuildContext context, {
    String? title,
    String message = '',
    String confirmBtnText = 'Aceptar',
    VoidCallback? onOkAction,
  }) {
    CoolAlert.show(
      context: context,
      type: CoolAlertType.info,
      title: title,
      text: '\n\n$message\n',
      confirmBtnText: ' $confirmBtnText ',
      loopAnimation: false,
      backgroundColor: FiicoColors.grayLite,
      confirmBtnColor: FiicoColors.purpleDark,
      animType: CoolAlertAnimType.slideInUp,
      onConfirmBtnTap: () {
        Navigator.of(context).pop();
        onOkAction?.call();
      },
      confirmBtnTextStyle: Style.title.copyWith(
        fontSize: FiicoFontSize.sm,
        color: FiicoColors.white,
      ),
    );
  }
}
