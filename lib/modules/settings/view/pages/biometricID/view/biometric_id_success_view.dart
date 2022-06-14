// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/settings/view/pages/biometricID/bloc/biometric_id_bloc.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class BiometricIDSuccessView extends StatefulWidget {
  const BiometricIDSuccessView({
    Key? key,
    this.userPinCode,
    this.isEnableBiometric,
  }) : super(key: key);

  final String? userPinCode;
  final bool? isEnableBiometric;

  @override
  State<BiometricIDSuccessView> createState() => BiometricIDSuccessViewState();
}

class BiometricIDSuccessViewState extends State<BiometricIDSuccessView> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.spaceAround,
        children: [
          _titlePinCodeView(),
          _biometricIconView(context),
          _validatedButton(context),
          _disableBiometricButton(context),
        ],
      ),
    );
  }

  Widget _biometricIconView(BuildContext context) {
    return const Icon(
      Icons.fingerprint,
      size: 100,
    );
  }

  Widget _titlePinCodeView() {
    return Container(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
        top: FiicoPaddings.twenyFour,
      ),
      height: 80,
      child: Text(
        FiicoLocale().activateBiometricUnlock,
        style: Style.title,
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _validatedButton(BuildContext context) {
    return Visibility(
      visible: !(widget.isEnableBiometric ?? false),
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.oneHundredTwenty,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: FiicoButton.pink(
            title: FiicoLocale().activate,
            ontap: () => _getAvailableBiometrics(context),
          ),
        ),
      ),
    );
  }

  Widget _disableBiometricButton(BuildContext context) {
    return Visibility(
      visible: widget.isEnableBiometric ?? false,
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.oneHundredTwenty,
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.maxFinite,
              child: Switch.adaptive(
                activeColor: FiicoColors.pink,
                value: widget.isEnableBiometric ?? false,
                onChanged: (isEnable) => _enableBiometrics(context, isEnable),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
              child: Text(
                FiicoLocale().turnBiometricUnlock,
                style: Style.subtitle,
                maxLines: FiicoMaxLines.four,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Generic functions

  Future<void> _getAvailableBiometrics(BuildContext context) async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException {
      availableBiometrics = <BiometricType>[];
    }

    if (availableBiometrics.isNotEmpty) {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: FiicoLocale().activateBiometricUnlock,
      );
      context
          .read<BiometricIDBloc>()
          .add(BiometricIDEnableRequest(isEnable: didAuthenticate));
    } else {
      FiicoAlertDialog.showWarnning(
        context,
        title: FiicoLocale().disableBiometricID,
        message: FiicoLocale().isNotPossibleEnableBiometric,
        onOkAction: () => FiicoRoute.back(context),
      );
    }
  }

  Future<void> _enableBiometrics(BuildContext context, bool isEnable) async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException {
      availableBiometrics = <BiometricType>[];
    }

    if (availableBiometrics.isNotEmpty) {
      bool didAuthenticate = await auth.authenticate(
        localizedReason: FiicoLocale().activateBiometricUnlock,
      );

      if (didAuthenticate) {
        context
            .read<BiometricIDBloc>()
            .add(BiometricIDInitEnable(isEnable: isEnable));
      }
    } else {
      FiicoAlertDialog.showWarnning(
        context,
        title: FiicoLocale().disableBiometricID,
        message: FiicoLocale().isNotPossibleEnableBiometric,
        onOkAction: () => FiicoRoute.back(context),
      );
    }
  }
}
