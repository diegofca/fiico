import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;

import 'bottom_nav_bar_button.dart';

class BottomNavBarItem extends StatefulWidget {
  const BottomNavBarItem({
    Key? key,
    this.active,
    required this.icon,
    this.text = '',
    this.curve,
    this.onPressed,
    required this.screen,
  }) : super(key: key);

  final bool? active;
  final IconData icon;
  final String text;
  final Curve? curve;
  final Function()? onPressed;
  final Widget screen;

  @override
  _BottomNavBarItemState createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SizedBox(
        height: 25,
        child: Semantics(
          label: widget.text,
          child: BottomNavBarButton(
            active: widget.active,
            onPressed: () {
              HapticFeedback.selectionClick();
              widget.onPressed?.call();
            },
            curve: widget.curve,
            icon: widget.icon,
            text: Text(
              widget.text,
              style: Style.desc.copyWith(
                color: FiicoColors.purpleDark,
                fontSize: FiicoFontSize.xs,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
