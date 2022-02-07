import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class GenericAppBar extends StatelessWidget with PreferredSizeWidget {
  const GenericAppBar({
    Key? key,
    this.text,
    this.textColor = FiicoColors.black,
    this.isShowBack = true,
    this.actions,
    this.title,
    this.bottomHeigth = 40,
  }) : super(key: key);

  final String? text;
  final Color? textColor;
  final List<Widget>? actions;
  final Widget? title;
  final double bottomHeigth;
  final bool? isShowBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      backgroundColor: FiicoColors.grayBackground,
      toolbarHeight: kToolbarHeight,
      leading: _getLeading(context),
      title: title,
      actions: actions ?? [],
      elevation: 0,
      centerTitle: false,
      bottom: text == null ? null : bottomWidget,
    );
  }

  Widget _getLeading(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Visibility(
        visible: isShowBack ?? true,
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: FiicoColors.grayDark,
        ),
      ),
    );
  }

  double get _bottomHeight => bottomHeigth;

  PreferredSizeWidget? get bottomWidget => PreferredSize(
        preferredSize: Size.fromHeight(_bottomHeight),
        child: Container(
          padding: const EdgeInsets.only(left: FiicoPaddings.thirtyTwo),
          width: double.maxFinite,
          child: Text(
            text ?? '',
            style: Style.title.copyWith(
              color: textColor,
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(
      (bottomWidget?.preferredSize.height ?? 0) + kToolbarHeight);
}
