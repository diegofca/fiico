import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgets/view/listView/budgets_list_item_view.dart';
import 'package:flutter/material.dart';
import 'emptyView/budgets_empty_view.dart';

class BudgetSuccessView extends StatelessWidget {
  const BudgetSuccessView({
    Key? key,
    required this.budgets,
  }) : super(key: key);

  final List<Budget> budgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Stack(
        children: [
          _emptyView(),
          _budgetsList(),
        ],
      ),
    );
  }

  Widget _emptyView() {
    return Visibility(
      visible: budgets.isEmpty,
      child: BudgetsEmptyView(
        onTapNewItem: () {
          print("new item");
        },
      ),
    );
  }

  Widget _budgetsList() {
    return Visibility(
      visible: budgets.isNotEmpty,
      child: Container(
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
          itemCount: budgets.length,
          itemBuilder: (context, index) {
            final budget = budgets[index];
            return BudgetListItemView(budget: budget);
          },
        ),
      ),
    );
  }
}
