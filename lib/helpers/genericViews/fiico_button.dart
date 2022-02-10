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
    required this.color,
    required this.onTap,
    this.image = '',
    this.textColor = FiicoColors.white,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);

  final String title;
  final Color color;
  final String? image;
  final Color? textColor;
  final EdgeInsets? padding;
  final VoidCallback onTap;

  static FiicoButton green({
    required VoidCallback ontap,
    String title = '',
    String image = '',
    EdgeInsets padding = EdgeInsets.zero,
  }) {
    return FiicoButton(
      color: FiicoColors.greenSoft,
      image: image,
      title: title,
      padding: padding,
      onTap: ontap,
    );
  }

  @override
  State<FiicoButton> createState() => FiicoButtonState();

  Size get preferredSize => throw UnimplementedError();
}

class FiicoButtonState extends State<FiicoButton> {
  final _sizeImage = const Size(20, 20);
  final _heightButton = 50.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap.call(),
      child: Padding(
        padding: widget.padding!,
        child: Container(
          height: _heightButton,
          margin: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.sixteen,
          ),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(FiicoPaddings.twenyFour),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.thirtyTwo,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: widget.image != null && widget.image!.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: FiicoPaddings.sixteen,
                    ),
                    child: SvgPicture.asset(
                      SVGImages.emptySafe,
                      width: _sizeImage.width,
                      height: _sizeImage.height,
                    ),
                  ),
                ),
                Text(
                  widget.title,
                  style: Style.subtitle.copyWith(
                    color: FiicoColors.white,
                    fontSize: FiicoFontSize.sm,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
