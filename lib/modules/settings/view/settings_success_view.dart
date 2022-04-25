import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/budgets/view/listView/budgets_list_item_view.dart';
import 'package:control/modules/createBudget/view/create_budget_bottom_view.dart';
import 'package:control/modules/createBudget/view/create_budget_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class SettingsSuccessView extends StatelessWidget {
  const SettingsSuccessView({
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
      child: _budgetsList(),
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

  void _addBudgetClickedAction(BuildContext context) {
    CreateBottomView().show(context, callbackName: (name) {
      FiicoRoute.send(context, CreateBudgetPage(budgetName: name));
    });
  }
}
