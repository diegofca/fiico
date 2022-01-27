import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FiicoButton extends StatefulWidget {
  const FiicoButton({
    Key? key,
    required this.title,
    required this.image,
    this.color = FiicoColors.greenSoft,
    this.textColor = FiicoColors.white,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String title;
  final String image;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? padding;

  @override
  State<FiicoButton> createState() => FiicoButtonState();

  Size get preferredSize => throw UnimplementedError();
}

class FiicoButtonState extends State<FiicoButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding!,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: false,
              child: SvgPicture.asset(
                SVGImages.emptySafe,
                width: 20,
                height: 20,
              ),
            ),
            Text(
              widget.title,
              style: Style.subtitle.copyWith(
                color: FiicoColors.white,
                fontSize: FiicoFontSize.md,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
