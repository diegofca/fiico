import 'package:flutter/material.dart';

abstract class FiicoFontFamily {
  ///Font Family base - Roboto
  static const String base = 'Kollektif';
}

/// Namespace for Default Letter Space
abstract class FiicoLetterSpace {
  ///Line Height 100%
  static const double normal = 0;

  ///Line Height 120%
  static const double negative = -0.02;
}

/// Namespace for Default Font Weights
abstract class FiicoFontWeight {
  ///FontWeight value of `w700`
  static const FontWeight bold = FontWeight.w700;

  ///FontWeight value of `w500`
  static const FontWeight medium = FontWeight.w500;

  ///FontWeight value of `w400`
  static const FontWeight regular = FontWeight.w400;
}

/// Namespace for Default Line height
abstract class FiicoLineHeight {
  ///Line Height 100%
  static const double normal = 1;

  ///Line Height 120%
  static const double tiny = 1.2;

  ///Line Height 150%
  static const double distant = 1.5;
}

/// Namespace for Default Font Size
abstract class FiicoMaxLines {
  static const int unlimited = 100;

  static const int two = 2;

  static const int four = 4;

  static const int ten = 10;
}

/// Namespace for Default Font Size
abstract class FiicoPaddings {
  ///Size 2px
  static const double two = 2;

  ///Size 3px
  static const double four = 4;

  ///Size 6px
  static const double six = 6;

  ///Size 8px
  static const double eight = 8;

  ///Size 12px
  static const double twelve = 12;

  ///Size 16px
  static const double sixteen = 16;

  ///Size 20px
  static const double twenty = 20;

  ///Size 24px
  static const double twenyFour = 24;

  ///Size 32px
  static const double thirtyTwo = 32;

  ///Size 64px
  static const double fourtySix = 46;

  ///Size 64px
  static const double sixtyTwo = 62;

  ///Size 64px
  static const double oneHundredTwenty = 120;
}

/// Namespace for Default Font Size
abstract class FiicoFontSize {
  ///Font Size 8px
  static const double small = 8;

  ///Font Size 10px
  static const double xxxs = 10;

  ///Font Size 12px
  static const double xxs = 12;

  ///Font Size 14px
  static const double xs = 14;

  ///Font Size 16px
  static const double xm = 16;

  ///Font Size 18px
  static const double sm = 18;

  ///Font Size 20px
  static const double md = 20;

  ///Font Size 24px
  static const double lg = 24;

  ///Font Size 30px
  static const double xl = 30;

  ///Font Size 34px
  static const double xxl = 34;
}
