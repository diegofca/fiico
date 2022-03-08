import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';

class SeparatorView extends StatelessWidget {
  const SeparatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FiicoColors.graySoft,
      height: 1,
    );
  }
}
