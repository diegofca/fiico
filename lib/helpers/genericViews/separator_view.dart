import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';

class SeparatorView extends StatelessWidget {
  const SeparatorView({
    Key? key,
    this.color = FiicoColors.graySoft,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 1,
    );
  }
}
