import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:control/modules/pinCodeUnlock/bloc/pincode_unlock_bloc.dart';
import 'package:control/modules/pinCodeUnlock/view/pincode_unlock_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinCodeUnlockPage extends StatelessWidget {
  const PinCodeUnlockPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().securityPinTitle,
        textColor: FiicoColors.black,
        isShowBack: false,
      ),
      body: BlocProvider(
        create: (context) => PinCodeUnlockBloc(),
        child: PinCodeUnlockView(user: user),
      ),
    );
  }
}

class PinCodeUnlockView extends StatelessWidget {
  const PinCodeUnlockView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PinCodeUnlockBloc, PinCodeUnlockState>(
      builder: (context, state) {
        return PinCodeUnlockSuccessView(
          userPinCode: user?.securityCode,
          isEnableBiometric: user?.authBiometric,
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case PinCodeUnlockStatus.init:
            if (state.isCorrectPin) {
              FiicoRoute.sendFade(context, MenuPage(user: user));
            } else {
              _showErrorAuthLogged(context);
            }
            break;
          default:
        }
      },
    );
  }

  void _showErrorAuthLogged(BuildContext context) {
    FiicoAlertDialog.showWarnning(
      context,
      title: FiicoLocale().invalidPin,
      message: FiicoLocale().invalidPinEnteredIsInvalid,
    );
  }
}
