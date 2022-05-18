import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgets/view/listView/budgets_list_item_view.dart';
import 'package:flutter/material.dart';

class SearchBudgetsListView extends StatelessWidget {
  const SearchBudgetsListView({
    Key? key,
    required this.budgets,
  }) : super(key: key);

  final items = 20;
  final List<Budget> budgets;

  final double _heigthCell = 100.0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: budgets.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.thirtyTwo,
          left: FiicoPaddings.thirtyTwo,
          bottom: FiicoPaddings.fourtySix,
        ),
        child: Wrap(
          children: [
            _headerView(),
            _listItemsView(),
          ],
        ),
      ),
    );
  }

  Widget _headerView() {
    return Container(
      height: 40,
      alignment: Alignment.topLeft,
      child: Text(
        '${FiicoLocale().foundBudgets} (${budgets.length})',
        style: Style.subtitle,
      ),
    );
  }

  Widget _listItemsView() {
    return Container(
      height: budgets.length * _heigthCell,
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
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: budgets.length,
        itemBuilder: (context, index) {
          final budget = budgets[index];
          return BudgetListItemView(budget: budget);
        },
      ),
    );
  }
}
