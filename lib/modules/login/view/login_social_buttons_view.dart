import 'dart:io';

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SocialLoginButtonsView extends StatelessWidget {
  const SocialLoginButtonsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _socialLoginButtons(context);
  }

  Widget _socialLoginButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
        vertical: FiicoPaddings.sixteen,
      ),
      width: double.maxFinite,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          _facebookButton(context),
          _googleButton(context),
          if (Platform.isIOS) _appleButton(context),
        ],
      ),
    );
  }

  Widget _googleButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LoginBloc>().add(
            const LoginIntentRequest(
              LoginIntentProvider.google,
            ),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FiicoPaddings.sixteen,
        ),
        child: SvgPicture.asset(
          SVGImages.googleIcon,
          width: 40,
        ),
      ),
    );
  }

  Widget _facebookButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LoginBloc>().add(
            const LoginIntentRequest(
              LoginIntentProvider.fb,
            ),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FiicoPaddings.sixteen,
        ),
        child: SvgPicture.asset(
          SVGImages.facebookIcon,
          width: 40,
        ),
      ),
    );
  }

  Widget _appleButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<LoginBloc>().add(
            const LoginIntentRequest(
              LoginIntentProvider.apple,
            ),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: FiicoPaddings.sixteen,
        ),
        child: SvgPicture.asset(
          SVGImages.appleIcon,
          width: 40,
        ),
      ),
    );
  }
}
