// ignore_for_file: must_be_immutable

import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:control/modules/register/bloc/sign_bloc.dart';
import 'package:control/modules/register/repository/sign_up_repository.dart';
import 'package:control/modules/register/view/sign_up_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignBloc(SignUpRepository()),
      child: const SignPageView(),
    );
  }
}

class SignPageView extends StatelessWidget {
  const SignPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignBloc, SignState>(
      builder: (context, state) {
        return SignSuccesView(state: state);
      },
      listener: (context, state) {
        _validateStatusView(context, state);
        _validateIfSignUpError(context, state);
        _validateIfSigUpComplete(context, state);
      },
    );
  }

  void _validateStatusView(BuildContext context, SignState state) {
    switch (state.status) {
      case SignStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfSigUpComplete(BuildContext context, SignState state) {
    if (state.signUpComplete) {
      FiicoRoute.sendReplace(context, const MenuPage());
    }
  }

  void _validateIfSignUpError(BuildContext context, SignState state) {
    if (state.signUpError) {
      FiicoAlertDialog.showWarnning(
        context,
        message: state.errorMgs ?? '',
      );
    }
  }
}
