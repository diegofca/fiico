// ignore_for_file: overridden_fields

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class BorderContainer extends Container {
  BorderContainer({
    this.padding,
    this.heigth = 60,
    this.alignment = Alignment.center,
    required this.child,
    Key? key,
  }) : super(key: key);

  final double heigth;
  @override
  final EdgeInsets? padding;
  @override
  final Widget child;
  @override
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: child,
      height: heigth,
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(
          color: FiicoColors.graySoft,
        ),
        borderRadius: BorderRadius.circular(FiicoPaddings.eight),
      ),
    );
  }
}
