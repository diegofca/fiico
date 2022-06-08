// ignore_for_file: must_be_immutable

import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/manager/language_manager.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:control/modules/login/repository/login_repository.dart';
import 'package:control/modules/login/view/login_success_view.dart';
import 'package:control/modules/menu/view/view.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
    required this.lang,
  }) : super(key: key);

  final Language lang;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(
        LoginRepository(),
      )..add(const LoginInitEvent()),
      child: LoginPageView(lang: lang),
    );
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({
    Key? key,
    required this.lang,
  }) : super(key: key);

  final Language lang;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async => false,
          child: LoginSuccesView(state: state, lang: lang),
        );
      },
      listener: (context, state) async {
        _validateStatusView(context, state);
        _validateIfLoginError(context, state);
        _validateIfLoginComplete(context, state);
        _validateIfRecoverPass(context, state);
      },
    );
  }

  void _validateStatusView(BuildContext context, LoginState state) {
    switch (state.status) {
      case LoginStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfLoginComplete(BuildContext context, LoginState state) async {
    if (state.loginComplete) {
      LanguageManager.setLanguageLogged(context, state.userLogged);
      FiicoRoute.sendReplace(context, MenuPage(user: state.userLogged));
    }
  }

  void _validateIfRecoverPass(BuildContext context, LoginState state) {
    if (state.isRecoverPass) {
      FiicoAlertDialog.showSuccess(
        context,
        message: 'El correo de recuperacion ha sido enviado correctamente',
      );
    }
  }

  void _validateIfLoginError(BuildContext context, LoginState state) {
    if (state.loginError) {
      FiicoAlertDialog.showWarnning(
        context,
        message: state.errorMgs ?? '',
      );
    }
  }
}
