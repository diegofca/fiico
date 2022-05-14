// ignore_for_file: constant_identifier_names

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/material.dart';

enum HomeCreateMovementBottomOption {
  add_entry,
  add_debt,
}

class HomeCreateMovementBottomView {
  final _options = {
    HomeCreateMovementBottomOption.add_entry: FiicoLocale.addIncome,
    HomeCreateMovementBottomOption.add_debt: FiicoLocale.addOutcome,
  };

  void show(
    BuildContext context, {
    required Function(HomeCreateMovementBottomOption) onOptionSelected,
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
                  height: 150,
                  child: _budgetListView(onOptionSelected),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _budgetListView(
      Function(HomeCreateMovementBottomOption) onOptionSelected) {
    return ListView.builder(
      itemCount: _options.length,
      itemBuilder: (context, index) {
        final option = _options.values.elementAt(index);
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
                      option,
                      textAlign: TextAlign.center,
                      style: Style.subtitle.copyWith(
                        fontSize: FiicoFontSize.md,
                        color: FiicoColors.purpleDark,
                      ),
                    ),
                  ),
                  onTap: () {
                    final key = _options.keys.elementAt(index);
                    Navigator.of(context).pop();
                    onOptionSelected.call(key);
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
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      child: SeparatorView(),
    );
  }
}
