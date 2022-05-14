import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/biometricID/bloc/biometric_id_bloc.dart';
import 'package:control/modules/settings/view/pages/biometricID/repository/biometric_id_repository.dart';
import 'package:control/modules/settings/view/pages/biometricID/view/biometric_id_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BiometricIDPage extends StatelessWidget {
  const BiometricIDPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: const GenericAppBar(
        text: "FaceID - TouchID",
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => BiometricIDBloc(
          BiometricIDRepository(),
        )..add(BiometricIDInitEnable(isEnable: user?.authBiometric)),
        child: BiometricIDPageView(user: user),
      ),
    );
  }
}

class BiometricIDPageView extends StatelessWidget {
  const BiometricIDPageView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricIDBloc, BiometricIDState>(
      builder: (context, state) {
        return BiometricIDSuccessView(
          userPinCode: user?.securityCode,
          isEnableBiometric: state.isInitEnable,
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case BiometricIDStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }

        if (state.isCorrectLoged) {
          _showCorrectLoggedAlert(context);
        }
      },
    );
  }

  void _showCorrectLoggedAlert(BuildContext context) {
    FiicoAlertDialog.showSuccess(
      context,
      title: FiicoLocale.successfulUpdate,
      message: FiicoLocale.changePinMessage,
      onOkAction: () => FiicoRoute.back(context),
    );
  }
}
