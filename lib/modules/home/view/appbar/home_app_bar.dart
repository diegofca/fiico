import 'package:control/helpers/extension/colors.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({
    Key? key,
    this.leading,
    this.actions,
    this.title,
    this.backgroundColor = FiicoColors.purpleDark,
    this.bottom,
    this.bottomHeigth = 90,
    this.heigth = 90,
  }) : super(key: key);

  final Widget? leading;
  final List<Widget>? actions;
  final Widget? title;
  final Color backgroundColor;
  final Widget? bottom;
  final double bottomHeigth;
  final double heigth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      backgroundColor: backgroundColor,
      toolbarHeight: heigth,
      leading: leading,
      title: title,
      actions: actions ?? [],
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      bottom: bottomWidget,
    );
  }

  double get _bottomHeight => bottom == null ? 0 : bottomHeigth;

  PreferredSizeWidget? get bottomWidget => PreferredSize(
        preferredSize: Size.fromHeight(_bottomHeight),
        child: bottom ?? Container(),
      );

  @override
  Size get preferredSize =>
      Size.fromHeight((bottomWidget?.preferredSize.height ?? 0) + heigth);
}
