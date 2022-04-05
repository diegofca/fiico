import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class IntroTwoStepView extends StatelessWidget {
  const IntroTwoStepView({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 120,
          left: 24,
          right: 24,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Style.subtitle.copyWith(
              color: FiicoColors.purpleLite,
              fontSize: FiicoFontSize.md,
            ),
            maxLines: FiicoMaxLines.four,
          ),
        ),
      ],
    );
  }
}
