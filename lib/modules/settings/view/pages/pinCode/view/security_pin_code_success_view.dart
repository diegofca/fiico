// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/modules/settings/view/pages/pinCode/bloc/security_pin_code_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SecurityPinCodeSuccessView extends StatefulWidget {
  const SecurityPinCodeSuccessView({
    Key? key,
    this.isChangeCode = false,
    this.userPinCode,
    this.isUnlockChange,
  }) : super(key: key);

  final String? userPinCode;
  final bool? isChangeCode;
  final bool? isUnlockChange;

  @override
  State<SecurityPinCodeSuccessView> createState() =>
      SecurityPinCodeSuccessViewState();
}

class SecurityPinCodeSuccessViewState
    extends State<SecurityPinCodeSuccessView> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

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
          _descriptionPinCodeView(),
          _titlePinCodeView(),
          _pinCodeView(context),
          _changeButton(context),
          _saveButton(context),
        ],
      ),
    );
  }

  Widget _pinCodeView(BuildContext context) {
    return PinCodeTextField(
      enabled: isPinCodeActive(),
      appContext: context,
      controller: _controller,
      focusNode: _focusNode,
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

  Widget _descriptionPinCodeView() {
    return const Padding(
      padding: EdgeInsets.only(
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
      ),
      child: Text(
        'Activa tu PIN para mayor seguridad. activa tu pin para mayor seguridad activa tu pin para mayor seguridad',
        style: Style.subtitle,
        maxLines: FiicoMaxLines.four,
      ),
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

  Widget _saveButton(BuildContext context) {
    return Visibility(
      visible: isPinCodeActive(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.oneHundredTwenty,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: FiicoButton.pink(
            title: 'Guardar',
            ontap: () => _savePinCode(context),
          ),
        ),
      ),
    );
  }

  Widget _changeButton(BuildContext context) {
    return Visibility(
      visible: isUserContentPin() && !isUnlockChangeActive(),
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.oneHundredTwenty,
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: FiicoButton.pink(
            title: 'Cambiar PIN',
            ontap: () => context
                .read<SecurityPinCodeBloc>()
                .add(const SecurityPinCodeChangeUnLockRequest(isUnLock: true)),
          ),
        ),
      ),
    );
  }

  //Generic functions
  bool isChangeCodeActive() {
    return widget.isChangeCode ?? false;
  }

  bool isUnlockChangeActive() {
    return widget.isUnlockChange ?? false;
  }

  bool isUserContentPin() {
    return widget.userPinCode?.isNotEmpty ?? false;
  }

  bool isPinCodeActive() {
    return isUnlockChangeActive() || (widget.userPinCode?.isEmpty ?? false);
  }

  String _titleStatusChangePin() {
    return !isUserContentPin()
        ? 'Argregar PIN'
        : !isUnlockChangeActive()
            ? 'Cambia tu PIN'
            : isChangeCodeActive()
                ? 'Ingresa tu antiguo PIN'
                : 'Ingresa tu nuevo PIN';
  }

  void _changePinCode(BuildContext context, String pinCode) {
    final bloc = context.read<SecurityPinCodeBloc>();
    if (widget.isChangeCode ?? false) {
      bloc.add(SecurityOldPinTextRequest(oldPinCode: pinCode));
    } else {
      bloc.add(SecurityNewPinTextRequest(pinCode: pinCode));
    }
  }

  void _savePinCode(BuildContext context) {
    final bloc = context.read<SecurityPinCodeBloc>();
    if (widget.isChangeCode ?? false) {
      if (widget.userPinCode == bloc.state.oldPin) {
        bloc.add(const SecurityPinCodeChangePINRequest(isChange: false));
        setState(() {
          _focusNode.requestFocus();
          _controller.clear();
        });
        return;
      }
      _showErrorPinDialog();
    } else {
      bloc.add(const SecurityPinUpdateIntentRequest());
    }
  }

  void _showErrorPinDialog() {
    FiicoAlertDialog.showWarnning(
      context,
      title: 'Error al actualizar tu PIN',
      message:
          'El PIN que has ingresado no es el correcto, intentalo de nuevo.',
    );
  }
}
