import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class BudgetDetailAddMovementView extends StatefulWidget {
  const BudgetDetailAddMovementView({
    Key? key,
    required this.title,
    required this.onAdded,
  }) : super(key: key);

  final String title;
  final VoidCallback onAdded;

  @override
  State<BudgetDetailAddMovementView> createState() =>
      BudgetDetailAddMovementViewState();

  Size get preferredSize => throw UnimplementedError();
}

class BudgetDetailAddMovementViewState
    extends State<BudgetDetailAddMovementView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onAdded.call(),
      child: Container(
        color: Colors.white,
        height: 70,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _icon(),
            _addView(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
        bottom: FiicoPaddings.eight,
        right: FiicoPaddings.sixteen,
      ),
      child: Container(
        width: 60,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FiicoPaddings.eight),
          color: FiicoColors.grayLite,
        ),
        child: const Padding(
          padding: EdgeInsets.all(FiicoPaddings.four),
          child: Icon(
            Icons.add,
            color: FiicoColors.pink,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget _addView() {
    return Text(
      widget.title,
      maxLines: 1,
      style: Style.desc.copyWith(
        color: FiicoColors.grayNeutral,
        fontSize: FiicoFontSize.xm,
      ),
    );
  }
}
