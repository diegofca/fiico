import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/cycle.dart';
import 'package:flutter/material.dart';

class CreateBudgetCycleSelectorView {
  final _options = [
    BudgetCycle.week(),
    BudgetCycle.twoWeeks(),
    BudgetCycle.month(),
    BudgetCycle.threeMonths(),
    BudgetCycle.sixMonths(),
    BudgetCycle.annual(),
  ];

  void show(
    BuildContext context, {
    required Function(BudgetCycle) onDurationSelected,
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
                  height: 350,
                  child: _budgetListView(onDurationSelected),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _budgetListView(Function(BudgetCycle) onDurationSelected) {
    return ListView.builder(
      itemCount: _options.length,
      itemBuilder: (context, index) {
        BudgetCycle option = _options[index];
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: FiicoPaddings.sixteen,
                  top: FiicoPaddings.sixteen,
                ),
                child: GestureDetector(
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      option.name,
                      textAlign: TextAlign.center,
                      style: Style.subtitle.copyWith(
                        fontSize: FiicoFontSize.md,
                        color: FiicoColors.purpleDark,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    onDurationSelected.call(option);
                  },
                ),
              ),
              _separatorLineView(),
            ],
          ),
        );
      },
    );
  }

  Widget _separatorLineView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      child: Container(
        color: FiicoColors.grayLite,
        height: 1,
      ),
    );
  }
}
