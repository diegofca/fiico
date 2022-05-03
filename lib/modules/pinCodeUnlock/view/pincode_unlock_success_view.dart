// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/modules/pinCodeUnlock/bloc/pincode_unlock_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeUnlockSuccessView extends StatefulWidget {
  const PinCodeUnlockSuccessView({
    Key? key,
    this.userPinCode,
    this.isEnableBiometric,
  }) : super(key: key);

  final String? userPinCode;
  final bool? isEnableBiometric;

  @override
  State<PinCodeUnlockSuccessView> createState() =>
      PinCodeUnlockSuccessViewState();
}

class PinCodeUnlockSuccessViewState extends State<PinCodeUnlockSuccessView> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    if (widget.isEnableBiometric ?? false) {
      _getAvailableBiometrics(context);
    }
  }

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
          _pinCodeView(context),
          _biometricView(context),
          _validatedButton(context),
        ],
      ),
    );
  }

  Widget _pinCodeView(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      obscuringWidget: const Icon(
        MdiIcons.shieldKey,
        color: FiicoColors.greenNeutral,
      ),
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 60,
        fieldWidth: 60,
        inactiveColor: FiicoColors.purpleSoft,
        activeColor: FiicoColors.greenNeutral,
        selectedColor: FiicoColors.purpleDark,
        activeFillColor: Colors.white,
        inactiveFillColor: FiicoColors.grayLite,
        selectedFillColor: FiicoColors.white,
        errorBorderColor: FiicoColors.pinkRed,
        disabledColor: FiicoColors.graySoft,
      ),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      boxShadows: const [
        BoxShadow(
          offset: Offset(0, 1),
          color: Colors.black12,
          blurRadius: 10,
        )
      ],
      onCompleted: (pinCode) => _changePinCode(context, pinCode),
      onChanged: (value) {},
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
        _titleStatusChangePin(),
        style: Style.title,
        maxLines: FiicoMaxLines.four,
      ),
    );
  }

  Widget _biometricView(BuildContext context) {
    return Visibility(
      visible: widget.isEnableBiometric ?? false,
      child: GestureDetector(
        onTap: () => _getAvailableBiometrics(context),
        child: const Icon(
          Icons.fingerprint,
          size: 100,
        ),
      ),
    );
  }

  Widget _validatedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.oneHundredTwenty,
      ),
      child: SizedBox(
        width: double.maxFinite,
        child: FiicoButton.pink(
          title: 'Validar',
          ontap: () => _savePinCode(context),
        ),
      ),
    );
  }

  //Generic functions
  String _titleStatusChangePin() {
    return 'Ingresa tu PIN';
  }

  void _changePinCode(BuildContext context, String pinCode) {
    final bloc = context.read<PinCodeUnlockBloc>();
    bloc.add(PinCodeUnlockPinTextRequest(pinCode: pinCode));
  }

  void _savePinCode(BuildContext context) {
    final bloc = context.read<PinCodeUnlockBloc>();
    final isCorrectPin = widget.userPinCode == bloc.state.pinCode;
    if (bloc.state.pinCode?.isNotEmpty ?? false) {
      bloc.add(PinCodeUnlockCorrectPinRequest(isCorrect: isCorrectPin));
    }
  }

  Future<void> _getAvailableBiometrics(BuildContext context) async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException {
      availableBiometrics = <BiometricType>[];
    }

    if (availableBiometrics.isNotEmpty) {
      bool didAuthenticate = await auth.authenticate(
          localizedReason: 'Please authenticate to show account balance');

      if (didAuthenticate) {
        final bloc = context.read<PinCodeUnlockBloc>();
        bloc.add(const PinCodeUnlockCorrectPinRequest(isCorrect: true));
      }
    }
  }
}
