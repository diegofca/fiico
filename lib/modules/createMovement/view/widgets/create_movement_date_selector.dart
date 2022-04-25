import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateMovementDateSelectorView {
  void show(
    BuildContext context, {
    DateTime? initalDate,
    required Function(DateTime) onDateSelected,
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
                child: _datePicker(context, initalDate, onDateSelected),
              ),
            );
          },
        );
      },
    );
  }

  Widget _datePicker(BuildContext context, DateTime? initalDate,
      Function(DateTime) onDateSelected) {
    DateTime _selectedDate = initalDate ?? DateTime.now();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Selecciona la fecha inicial...",
          style: Style.title.copyWith(
            fontSize: FiicoFontSize.md,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          child: SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _selectedDate,
              onDateTimeChanged: (val) {
                _selectedDate = val;
              },
            ),
          ),
        ),
        FiicoButton.pink(
          title: 'Seleccionar fecha',
          ontap: () {
            onDateSelected(_selectedDate);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
