// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/debt_daily.dart';
import 'package:control/models/movement.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DebtDailyBottoView {
  final _priceController = TextEditingController();
  final _nameController = TextEditingController();

  final _currencyFormarted = CurrencyTextInputFormatter(
    decimalDigits: 0,
    symbol: '',
  );
  void show(
    BuildContext context,
    Movement? movement, {
    required Function(DebtDaily) callbackValue,
  }) {
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
        _titleView(movement),
        _nameTextfieldView(),
        _valueTextfieldView(movement),
        _recommendationView(),
      ],
    );
  }

  Widget _titleView(Movement? movement) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
        bottom: FiicoPaddings.sixteen,
      ),
      child: Text(
        "${FiicoLocale().addTheNewValueOf} ${movement?.name}",
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.start,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _valueTextfieldView(Movement? movement) {
    return BorderContainer(
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
    );
  }

  Widget _nameTextfieldView() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.sixteen,
      ),
      child: BorderContainer(
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: FiicoTextfield(
                  keyboardType: TextInputType.name,
                  hintText: FiicoLocale().outcome,
                  textEditingController: _nameController,
                  textColor: FiicoColors.grayDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendationView() {
    return Container(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        FiicoLocale().rememberThatAfterAddingYourExpense,
        maxLines: FiicoMaxLines.four,
        textAlign: TextAlign.start,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xs,
          color: FiicoColors.grayNeutral,
        ),
      ),
    );
  }

  Widget _createButtonView(BuildContext context, Movement? movement,
      Function(DebtDaily) callbackValue) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.sixteen,
        horizontal: FiicoPaddings.sixteen,
      ),
      child: FiicoButton(
        title: FiicoLocale().addNewExpense,
        color: movement?.getTypeColor() ?? FiicoColors.gold,
        image: SVGImages.checkMarkIcon,
        onTap: () async {
          final value = _currencyFormarted.getUnformattedValue();
          final name = _nameController.text;
          final user = await Preferences.get.getUser();
          final debt = DebtDaily(
            value: value.toDouble(),
            userName: user?.userName,
            createdAt: Timestamp.now(),
            name: name,
          );
          if (name.isNotEmpty && value > 0) {
            Navigator.of(context).pop();
            callbackValue(debt);
          }
        },
      ),
    );
  }
}
