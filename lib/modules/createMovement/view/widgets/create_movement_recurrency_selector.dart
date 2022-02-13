import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/recurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateMovementRecurrencySelectorView {
  final _options = [
    Recurrency('Semanal', "week"),
    Recurrency('Quincenal', "biweekly"),
    Recurrency('Mensual', "monthly"),
    Recurrency('Anual', "annual"),
  ];

  void show(
    BuildContext context, {
    required Function(Recurrency) onRecurrencySelected,
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
                  height: 250,
                  child: _budgetListView(onRecurrencySelected),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _budgetListView(Function(Recurrency) onRecurrencySelected) {
    return ListView.builder(
      itemCount: _options.length,
      itemBuilder: (context, index) {
        Recurrency option = _options[index];
        return Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  top: 16,
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
                    onRecurrencySelected.call(option);
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
        horizontal: 16,
      ),
      child: Container(
        color: FiicoColors.grayLite,
        height: 1,
      ),
    );
  }
}
