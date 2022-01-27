import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';
import '../fonts_params.dart';

///Typography Definitions
abstract class Style {
  ///font-size: [XpFontSize.xxxs]px;
  ///line-height: [XpLineHeight.normal]*100;
  ///font-weight: [XpFontWeight.medium];
  ///letter-spacing: [XpLetterSpace.normal]
  static const title = TextStyle(
    fontSize: FiicoFontSize.lg,
    height: FiicoLineHeight.normal,
    fontWeight: FiicoFontWeight.bold,
    letterSpacing: FiicoLetterSpace.normal,
    fontFamily: FiicoFontFamily.base,
    color: FiicoColors.grayDark,
  );

  static const subtitle = TextStyle(
    fontSize: FiicoFontSize.xs,
    height: FiicoLineHeight.normal,
    fontWeight: FiicoFontWeight.medium,
    letterSpacing: FiicoLetterSpace.normal,
    fontFamily: FiicoFontFamily.base,
    color: FiicoColors.grayDark,
  );

  static const desc = TextStyle(
    fontSize: FiicoFontSize.xxxs,
    height: FiicoLineHeight.normal,
    fontWeight: FiicoFontWeight.medium,
    letterSpacing: FiicoLetterSpace.normal,
    fontFamily: FiicoFontFamily.base,
    color: FiicoColors.grayDark,
  );
}
