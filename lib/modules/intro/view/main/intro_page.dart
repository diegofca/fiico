// ignore_for_file: must_be_immutable, import_of_legacy_library_into_null_safe

import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/login/view/login_page.dart';
import 'package:control/modules/splash/bloc/splash_bloc.dart';
import 'package:control/modules/splash/repository/splash_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  final videos = [
    'assets/videos/login_video_1.mp4',
    'assets/videos/login_video_2.mp4'
  ];

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

    var element = videos[Random().nextInt(videos.length)];
    _controller = VideoPlayerController.asset(element);
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, SplashState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _getVideoBackground(context),
            _getIntrosViews(),
          ],
        );
      },
    );
  }

  Widget _getVideoBackground(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: VideoPlayer(_controller),
    );
  }

  Widget _getIntrosViews() {
    return SafeArea(
      top: false,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(
          right: FiicoPaddings.thirtyTwo,
          left: FiicoPaddings.thirtyTwo,
          top: FiicoPaddings.sixtyTwo,
        ),
        child: DefaultTextStyle(
          style: Style.desc.copyWith(
            color: FiicoColors.white.withAlpha(100),
            fontSize: FiicoFontSize.md,
          ),
          maxLines: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                SVGImages.valiuIcon,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
              ),
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
              GestureDetector(
                onTap: () async {
                  final lang = await Preferences.get.getLang();
                  FiicoRoute.sendFade(context, LoginPage(lang: lang));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: FiicoPaddings.sixteen,
                    vertical: FiicoPaddings.sixteen,
                  ),
                  margin: const EdgeInsets.only(
                    bottom: FiicoPaddings.sixteen,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      FiicoPaddings.thirtyTwo,
                    ),
                    color: FiicoColors.purpleDark.withOpacity(0.3),
                  ),
                  child: const Icon(
                    MdiIcons.arrowRightBold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
