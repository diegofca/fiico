import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/pinCode/bloc/security_pin_code_bloc.dart';
import 'package:control/modules/settings/view/pages/pinCode/repository/security_pin_code_repository.dart';
import 'package:control/modules/settings/view/pages/pinCode/view/security_pin_code_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityPinCodePage extends StatelessWidget {
  const SecurityPinCodePage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale.securityPinTitle,
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => SecurityPinCodeBloc(
          SecurityPinCodeRepository(),
        )..add(SecurityPinCodeChangePINRequest(
            isChange: user?.securityCode?.isNotEmpty)),
        child: SecurityPinCodePageView(user: user),
      ),
    );
  }
}

class SecurityPinCodePageView extends StatelessWidget {
  const SecurityPinCodePageView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecurityPinCodeBloc, SecurityPinCodeState>(
      builder: (context, state) {
        return SecurityPinCodeSuccessView(
          isChangeCode: state.isChangePinCode,
          userPinCode: user?.securityCode,
          isUnlockChange: state.isUnlockChange,
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case SecurityPinCodeStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }

        if (state.isPinUpdated) {
          FiicoAlertDialog.showSuccess(
            context,
            title: FiicoLocale.successfulUpdate,
            message:
                'Hemos actualizado tu PIN de seguridad, recuerda actualizarlo continuamente para tener tus datos seguros.',
            onOkAction: () => FiicoRoute.back(context),
          );
        }
      },
    );
  }
}
