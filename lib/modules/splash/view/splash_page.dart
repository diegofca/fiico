// ignore_for_file: must_be_immutable

import 'dart:async';
import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/manager/badgeManager.dart';
import 'package:control/modules/intro/view/main/intro_page.dart';
import 'package:control/modules/menu/view/view.dart';
import 'package:control/modules/pinCodeUnlock/view/pincode_unlock_page.dart';
import 'package:control/modules/splash/bloc/splash_bloc.dart';
import 'package:control/modules/splash/repository/splash_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';

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
        _configAll(context);
      },
    );
  }

  void _configAll(BuildContext context) {
    precacheImage(
      const AssetImage(SVGImages.purpleBg),
      context,
      size: MediaQuery.of(context).size,
    );
  }

  void _validateIfLogged(BuildContext context, SplashState state) {
    Timer(const Duration(milliseconds: 2500), () async {
      if (state.isLogged) {
        _processLogged(context);
      } else {
        FiicoRoute.sendFade(context, const IntroPage());
      }
    });
  }

  void _processLogged(BuildContext context) async {
    final user = await Preferences.get.getUser();
    final activePinCode = user?.securityCode?.isNotEmpty ?? false;
    final page =
        activePinCode ? PinCodeUnlockPage(user: user) : MenuPage(user: user);
    FiicoRoute.sendFade(context, page);
    Smartlook.startRecording();
    BadgeManager.removeBadge();
  }
}
