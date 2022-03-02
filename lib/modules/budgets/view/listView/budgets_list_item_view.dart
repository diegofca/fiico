import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class BudgetListItemView extends StatefulWidget {
  const BudgetListItemView({
    Key? key,
    required this.budget,
  }) : super(key: key);

  final Budget budget;

  @override
  State<BudgetListItemView> createState() => BudgetListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class BudgetListItemViewState extends State<BudgetListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FiicoRoute.send(
        context,
        BudgetDetailPage(budget: widget.budget),
      ),
      child: Container(
        height: 100,
        width: double.maxFinite,
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _iconView(),
            _nameStatusView(),
            _totalPriceView(),
          ],
        ),
      ),
    );
  }

  Widget _iconView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
        right: FiicoPaddings.twenyFour,
        left: FiicoPaddings.twenyFour,
      ),
      child: Container(
        width: 75,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
          color: FiicoColors.grayLite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FiicoPaddings.sixteen),
          child: FiicoImageNetwork.budget(
            iconData: widget.budget.icon?.getIcon(),
          ),
        ),
      ),
    );
  }

  Widget _nameStatusView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameView(),
          _statusView(),
        ],
      ),
    );
  }

  Widget _nameView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.budget.name ?? '',
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _statusView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.eight),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              color: widget.budget.getStatusColor(),
              size: 12,
            ),
          ),
          Text(
            widget.budget.status ?? '',
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalPriceView() {
    return Padding(
      padding: const EdgeInsets.only(right: FiicoPaddings.twenyFour),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
            child: Text(
              "Total",
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xm,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: FiicoPaddings.eight),
            child: Text(
              widget.budget.totalBalance?.toCurrencyCompat() ?? '',
              style: const TextStyle(
                color: FiicoColors.grayDark,
                fontWeight: FontWeight.bold,
                fontSize: FiicoFontSize.xs,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
