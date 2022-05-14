import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BudgetsEmptyView extends StatefulWidget {
  const BudgetsEmptyView({
    Key? key,
    required this.onTapNewItem,
  }) : super(key: key);

  final VoidCallback onTapNewItem;

  @override
  State<BudgetsEmptyView> createState() => BudgetsEmtpyViewState();
}

class BudgetsEmtpyViewState extends State<BudgetsEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: const [
          BoxShadow(
            color: FiicoColors.grayLite,
            blurRadius: 5,
            spreadRadius: 20,
          )
        ],
      ),
      child: _emptyMyBudgets(),
    );
  }

  Widget _emptyMyBudgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _emptyBudgetsIconView(),
        _notHaveBudgetsTextView(),
        _createButtonView()
      ],
    );
  }

  Widget _emptyBudgetsIconView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.thirtyTwo),
      child: SvgPicture.asset(
        SVGImages.emptyBudgets,
        height: 150,
      ),
    );
  }

  Widget _notHaveBudgetsTextView() {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.eight),
      child: Text(
        FiicoLocale.youHaveNoActiveBudgets,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xm,
          color: FiicoColors.graySoft,
        ),
      ),
    );
  }

  Widget _createButtonView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.twenyFour),
      child: SizedBox(
        child: FiicoButton.pink(
          title: FiicoLocale.createNewBudget,
          ontap: () => widget.onTapNewItem.call(),
        ),
      ),
    );
  }
}
