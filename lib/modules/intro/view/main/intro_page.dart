// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/modules/login/view/login_page.dart';
import 'package:control/modules/menu/view/view.dart';
import 'package:control/modules/splash/bloc/splash_bloc.dart';
import 'package:control/modules/splash/repository/splash_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc(
        SplashRepository(),
      ),
      child: const IntroPageView(),
    );
  }
}

class IntroPageView extends StatefulWidget {
  const IntroPageView({
    Key? key,
  }) : super(key: key);

  @override
  State<IntroPageView> createState() => IntroPageViewState();
}

class IntroPageViewState extends State<IntroPageView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    initControllerState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void initControllerState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller =
        VideoPlayerController.asset("assets/videos/login_video_1.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _getVideoBackground(),
            _getIntrosViews(),
          ],
        );
      },
      listener: (context, state) async {
        _validateIfLogged(context, state);
      },
    );
  }

  Widget _getVideoBackground() {
    return VideoPlayer(_controller);
  }

  Widget _getIntrosViews() {
    return SafeArea(
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(
          right: FiicoPaddings.twenyFour,
          left: FiicoPaddings.twenyFour,
          top: FiicoPaddings.sixtyTwo,
        ),
        child: DefaultTextStyle(
          style: Style.desc.copyWith(
            color: FiicoColors.grayBackground,
            fontSize: FiicoFontSize.md,
          ),
          maxLines: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FadeAnimatedText(
                    'Ahora podras ahorrar con Fiico y controlar tus gastos e ingresos.',
                    textAlign: TextAlign.center,
                    duration: const Duration(seconds: 3),
                    fadeOutBegin: 0.8,
                    fadeInEnd: 0.2,
                  ),
                  FadeAnimatedText(
                    'y comenzar de nuevo',
                    textAlign: TextAlign.center,
                    duration: const Duration(seconds: 3),
                    fadeOutBegin: 0.8,
                    fadeInEnd: 0.2,
                  ),
                ],
              ),
              FiicoButton(
                title: 'Saltar',
                color: FiicoColors.clear,
                onTap: () => FiicoRoute.send(context, LoginPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validateIfLogged(BuildContext context, SplashState state) {
    final page = state.isLogged ? const MenuPage() : const LoginPage();
    FiicoRoute.sendReplace(context, page);
  }
}
