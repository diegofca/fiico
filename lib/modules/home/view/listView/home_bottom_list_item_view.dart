import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeSelectorBudgetListItemView extends StatefulWidget {
  const HomeSelectorBudgetListItemView({
    Key? key,
    required this.budget,
    required this.onSelected,
  }) : super(key: key);

  final Budget budget;
  final Function(Budget) onSelected;

  @override
  State<HomeSelectorBudgetListItemView> createState() =>
      HomeSelectorBudgetListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeSelectorBudgetListItemViewState
    extends State<HomeSelectorBudgetListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onSelected.call(
        widget.budget,
      ),
      child: Container(
        height: 70,
        color: FiicoColors.white,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _iconView(),
            _nameStatusView(),
            _onOpenDetailBudgetView(context),
          ],
        ),
      ),
    );
  }

  Widget _iconView() {
    return Padding(
      padding: const EdgeInsets.only(
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
        child: Center(
          child: FiicoImageNetwork(
            iconData: widget.budget.icon?.getIcon(),
            size: 30,
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

  Widget _onOpenDetailBudgetView(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
        FiicoRoute.send(context, BudgetDetailPage(budget: widget.budget));
      },
      icon: const Icon(MdiIcons.arrowRight),
    );
  }
}
