// ignore_for_file: must_be_immutable

import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:control/modules/login/repository/login_repository.dart';
import 'package:control/modules/login/view/login_success_view.dart';
import 'package:control/modules/menu/view/view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(LoginRepository()),
      child: const LoginPageView(),
    );
  }
}

class LoginPageView extends StatelessWidget {
  const LoginPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      builder: (context, state) {
        return LoginSuccesView(state: state);
      },
      listener: (context, state) async {
        _validateStatusView(context, state);
        _validateIfLoginError(context, state);
        _validateIfLoginComplete(context, state);
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

  void _validateIfLoginComplete(BuildContext context, LoginState state) {
    if (state.loginComplete) {
      FiicoRoute.sendReplace(context, MenuPage(user: state.userLogged));
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
