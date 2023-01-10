import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/slide_action.dart';
import 'package:flutter/material.dart';

class FiicoSlideButton extends StatefulWidget {
  const FiicoSlideButton({
    Key? key,
    required this.title,
    required this.color,
    required this.onSubmit,
    required this.onStart,
    this.textColor = FiicoColors.white,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String title;
  final Color color;
  final Color? textColor;
  final EdgeInsets? padding;

  final VoidCallback onSubmit;

  final bool Function()? onStart;

  @override
  State<FiicoSlideButton> createState() => FiicoSlideButtonState();
}

class FiicoSlideButtonState extends State<FiicoSlideButton> {
  final _heightButton = 50.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding!,
      child: Container(
        height: _heightButton,
        margin: const EdgeInsets.symmetric(
          vertical: FiicoPaddings.thirtyTwo,
        ),
        child: SlideAction(
          height: _heightButton,
          sliderButtonIconPadding: 6,
          innerColor: widget.textColor,
          outerColor: widget.color,
          sliderButtonIcon: Icon(Icons.check, color: widget.color),
          borderRadius: 24,
          elevation: 2,
          onSubmit: () => widget.onSubmit.call(),
          onStart: () => widget.onStart!.call(),
          child: Text(
            widget.title,
            style: Style.title.copyWith(
              color: widget.textColor,
              fontSize: FiicoFontSize.xm,
            ),
          ),
          sliderRotate: false,
        ),
      ),
    );
  }
}
