import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/models/recurrency.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CreateMovementDaySelectorView {
  static var weekLimit = [];

  void show(
    BuildContext context, {
    List<int>? selectedDays,
    Recurrency? recurrency,
    required Function(List<int>) onDaySelected,
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
                child: _datePicker(
                  context,
                  recurrency,
                  selectedDays,
                  onDaySelected,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _datePicker(BuildContext context, Recurrency? recurrency,
      List<int>? selectedDays, Function(List<int>) onDaySelected) {
    var _selectedDays = selectedDays ?? [DateTime.now().day];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Selecciona un día",
          style: Style.title.copyWith(
            fontSize: FiicoFontSize.md,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          child: SizedBox(
            height: 300,
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              selectionMode: getSelectionMode(recurrency),
              toggleDaySelection: true,
              navigationMode: DateRangePickerNavigationMode.none,
              selectionColor: FiicoColors.purpleDark,
              todayHighlightColor: FiicoColors.pink,
              backgroundColor: FiicoColors.grayLite,
              onSelectionChanged: (args) {
                if (args.value is DateTime) {
                  _selectedDays = [args.value];
                } else if (args.value is List<DateTime>) {
                  _selectedDays = args.value;
                }
              },
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: Style.desc.copyWith(
                  color: FiicoColors.clear,
                ),
              ),
            ),
          ),
        ),
        FiicoButton.pink(
          title: 'Seleccionar dia',
          ontap: () {
            onDaySelected(_selectedDays);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  //General functions
  DateRangePickerSelectionMode getSelectionMode(Recurrency? recurrency) {
    switch (recurrency?.value) {
      case Recurrency.multipleID:
        return DateRangePickerSelectionMode.multiple;
      default:
        return DateRangePickerSelectionMode.single;
    }
  }
}
