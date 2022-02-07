import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/modules/home/view/listView/home_bottom_list_item_view.dart';
import 'package:flutter/material.dart';

class HomeBottomView {
  void show(
    BuildContext context,
    List<Budget> budgets, {
    required Function(Budget) onBudgetSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 280),
              padding: EdgeInsets.only(
                left: FiicoPaddings.eight,
                right: FiicoPaddings.eight,
                top: FiicoPaddings.thirtyTwo,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(FiicoPaddings.twenyFour),
                  topRight: Radius.circular(FiicoPaddings.twenyFour),
                ),
              ),
              child: SafeArea(
                child: SizedBox(
                  height: budgets.length * 96,
                  child: _budgetListView(budgets, onBudgetSelected),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _budgetListView(
      List<Budget> budgets, Function(Budget) onBudgetSelected) {
    return ListView.builder(
      itemCount: budgets.length,
      itemBuilder: (context, index) {
        Budget budget = budgets[index];
        return Container(
          margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
          child: HomeSelectorBudgetListItemView(
            budget: budget,
            onSelected: (budget) {
              Navigator.of(context).pop();
              onBudgetSelected.call(budget);
            },
          ),
        );
      },
    );
  }
}
