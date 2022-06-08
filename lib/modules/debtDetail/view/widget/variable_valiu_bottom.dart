// ignore_for_file: constant_identifier_names

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/movement.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:control/helpers/extension/num.dart';

class VariableValueBottoView {
  final _priceController = TextEditingController();

  final _currencyFormarted = CurrencyTextInputFormatter(
    decimalDigits: 0,
    symbol: '',
  );
  void show(
    BuildContext context,
    Movement? movement, {
    required Function(num) callbackValue,
  }) {
    _priceController.text = movement?.value?.toExactlyCurrency() ?? '';
    _currencyFormarted.format(_priceController.text);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              padding: EdgeInsets.only(
                left: FiicoPaddings.thirtyTwo,
                right: FiicoPaddings.thirtyTwo,
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
                child: Wrap(
                  children: [
                    _entryNameView(movement),
                    _createButtonView(context, movement, callbackValue),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _entryNameView(Movement? movement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: FiicoPaddings.eight,
            bottom: FiicoPaddings.sixteen,
          ),
          child: Text(
            "${FiicoLocale().addTheNewValueOf} ${movement?.name} ${FiicoLocale().forThisCycle}",
            maxLines: FiicoMaxLines.four,
            textAlign: TextAlign.start,
            style: Style.subtitle.copyWith(
              fontSize: FiicoFontSize.xm,
            ),
          ),
        ),
        BorderContainer(
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: FiicoPaddings.sixteen,
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  movement?.currency ?? '',
                  textAlign: TextAlign.left,
                  style: Style.subtitle.copyWith(
                    color: movement?.getTypeColor(),
                    fontWeight: FiicoFontWeight.bold,
                    fontSize: FiicoFontSize.sm,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: FiicoTextfield(
                    keyboardType: TextInputType.number,
                    hintText: FiicoLocale().enterAmount,
                    textEditingController: _priceController,
                    textColor: movement?.getTypeColor(),
                    inputFormatters: <TextInputFormatter>[_currencyFormarted],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            top: FiicoPaddings.sixteen,
            left: FiicoPaddings.sixteen,
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            FiicoLocale().theNewValueWillBeUpdated,
            maxLines: FiicoMaxLines.four,
            textAlign: TextAlign.start,
            style: Style.subtitle.copyWith(
              fontSize: FiicoFontSize.xs,
              color: FiicoColors.grayNeutral,
            ),
          ),
        )
      ],
    );
  }

  Widget _createButtonView(
      BuildContext context, Movement? movement, Function(num) callbackValue) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.sixteen,
        horizontal: FiicoPaddings.sixteen,
      ),
      child: FiicoButton(
        title: FiicoLocale().markAsPaid,
        color: movement?.getTypeColor() ?? FiicoColors.gold,
        image: SVGImages.checkMarkIcon,
        onTap: () {
          Navigator.of(context).pop();
          final value = _currencyFormarted.getUnformattedValue();
          if (value > 0) {
            callbackValue(value);
          }
        },
      ),
    );
  }
}
