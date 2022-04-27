// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/modules/intro/view/main/intro_page.dart';
import 'package:control/modules/menu/view/view.dart';
import 'package:control/modules/splash/bloc/splash_bloc.dart';
import 'package:control/modules/splash/repository/splash_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(
        SplashRepository(),
      )..add(const SplashUserRequest()),
      child: const SplashPageView(),
    );
  }
}

class SplashPageView extends StatelessWidget {
  const SplashPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      builder: (context, state) {
        return Container(
          color: FiicoColors.purpleDark,
          child: Image.asset(
            GIFmages.valiuIcon,
          ),
        );
      },
      listener: (context, state) {
        _validateIfLogged(context, state);
      },
    );
  }

  void _validateIfLogged(BuildContext context, SplashState state) {
    Timer(const Duration(milliseconds: 3000), () async {
      final user = await Preferences.get.getUser();
      final page = state.isLogged ? MenuPage(user: user) : const IntroPage();
      FiicoRoute.sendFade(context, page);
    });
  }
}
