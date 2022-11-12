import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final double size;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    this.size = FiicoFontSize.xm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: Style.desc.copyWith(
            fontSize: FiicoFontSize.xs,
          ),
        )
      ],
    );
  }
}
