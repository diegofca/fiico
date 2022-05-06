import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class GenericAppBar extends StatelessWidget with PreferredSizeWidget {
  const GenericAppBar({
    Key? key,
    this.text,
    this.textColor = FiicoColors.black,
    this.bgColor = FiicoColors.grayBackground,
    this.backColor = FiicoColors.grayDark,
    this.isShowBack = true,
    this.textClicked,
    this.actions,
    this.title,
    this.bottomHeigth = 40,
  }) : super(key: key);

  final String? text;
  final Color? textColor;
  final Color? bgColor;
  final Color? backColor;
  final List<Widget>? actions;
  final Widget? title;
  final double bottomHeigth;
  final bool? isShowBack;
  final VoidCallback? textClicked;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      key: key,
      backgroundColor: bgColor,
      toolbarHeight: kToolbarHeight,
      leading: _getLeading(context),
      title: title,
      actions: actions ?? [],
      elevation: FiicoPaddings.zero,
      centerTitle: false,
      bottom: text == null ? null : bottomWidget,
    );
  }

  Widget _getLeading(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Visibility(
        visible: isShowBack ?? true,
        child: Padding(
          padding: const EdgeInsets.only(
            left: FiicoPaddings.sixteen,
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: backColor,
          ),
        ),
      ),
    );
  }

  double get _bottomHeight => bottomHeigth;

  PreferredSizeWidget? get bottomWidget => PreferredSize(
        preferredSize: Size.fromHeight(_bottomHeight),
        child: GestureDetector(
          onTap: () => textClicked?.call(),
          child: Container(
            padding: const EdgeInsets.only(left: FiicoPaddings.thirtyTwo),
            width: double.maxFinite,
            child: Text(
              text ?? '',
              maxLines: FiicoMaxLines.two,
              style: Style.title.copyWith(
                color: textColor,
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => Size.fromHeight(
      (bottomWidget?.preferredSize.height ?? 0) + kToolbarHeight);
}
