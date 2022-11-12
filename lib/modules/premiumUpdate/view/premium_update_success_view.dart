// ignore_for_file: must_be_immutable

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class PremiumUpdateSuccessView extends StatelessWidget {
  const PremiumUpdateSuccessView({
    Key? key,
  }) : super(key: key);

  final double heigth = 360;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        children: [
          _imageView(context),
          _title(),
          _descriptionPremium(),
        ],
      ),
    );
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
        top: FiicoPaddings.eight,
      ),
      child: Text(
        FiicoLocale().updateYourPremiumPlan,
        style: Style.title.copyWith(
          color: FiicoColors.black,
          fontSize: FiicoFontSize.lg,
        ),
      ),
    );
  }

  Widget _imageView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.thirtyTwo,
      ),
      child: SvgPicture.asset(
        SVGImages.handDolarIcon,
        width: double.maxFinite,
        fit: BoxFit.fitWidth,
        height: heigth - 90,
      ),
    );
  }

  Widget _descriptionPremium() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.thirtyTwo,
        vertical: FiicoPaddings.twenyFour,
      ),
      child: Text(
        FiicoLocale().learnAboutYourPremiumPlan,
        maxLines: FiicoMaxLines.ten,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xm,
          color: FiicoColors.grayNeutral,
        ),
      ),
    );
  }
}
