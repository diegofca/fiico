import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AboutOfSuccessView extends StatelessWidget {
  AboutOfSuccessView({
    Key? key,
    this.version,
  }) : super(key: key);

  final String? version;

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _bodyView(context),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: FiicoColors.grayLite,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.centerShadow],
      ),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Image.asset(
            GIFmages.bumbles,
            fit: BoxFit.cover,
            color: FiicoColors.pink.withAlpha(60),
            gaplessPlayback: true,
            height: 600,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.twenyFour,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.twenyFour,
              ),
              child: _inputsListView(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputsListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        _crownImage(context),
        _versionTextView(),
        _cancelTextConditions(),
      ],
    );
  }

  Widget _crownImage(BuildContext context) {
    return SvgPicture.asset(
      SVGImages.valiuIcon,
      color: FiicoColors.purpleDark,
    );
  }

  Widget _versionTextView() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(FiicoPaddings.sixteen),
        child: Text(
          'v $version',
          maxLines: FiicoMaxLines.two,
          textAlign: TextAlign.center,
          style: Style.subtitle.copyWith(
            color: FiicoColors.grayNeutral,
            fontSize: FiicoFontSize.xm,
          ),
        ),
      ),
    );
  }

  Widget _cancelTextConditions() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        'Hecho con ❤️ en Bogotá, Co.',
        maxLines: FiicoMaxLines.two,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }
}
