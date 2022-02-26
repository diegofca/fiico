import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/duration.dart';
import 'package:flutter/material.dart';

class CreateBudgetDurationSelectorView {
  final _options = [
    BudgetDuration.month(),
    BudgetDuration.threeMonths(),
    BudgetDuration.sixMonths(),
    BudgetDuration.annual(),
    BudgetDuration.custom(),
  ];

  void show(
    BuildContext context, {
    required Function(BudgetDuration) onDurationSelected,
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
                  height: 300,
                  child: _budgetListView(onDurationSelected),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _budgetListView(Function(BudgetDuration) onDurationSelected) {
    return ListView.builder(
      itemCount: _options.length,
      itemBuilder: (context, index) {
        BudgetDuration option = _options[index];
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
