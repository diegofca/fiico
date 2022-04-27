import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_cycle_calendar.dart';
import 'package:control/models/budget.dart';
import 'package:flutter/material.dart';

class CreateMovementDaySelectorView {
  void show(
    BuildContext context, {
    List<int>? selectedDays,
    required Budget? budget,
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
                  budget,
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

  Widget _datePicker(BuildContext context, Budget? budget,
      List<int>? selectedDays, Function(List<int>) onDaySelected) {
    var _selectedDays = selectedDays ?? [];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _getTitle(),
          style: Style.title.copyWith(
            fontSize: FiicoFontSize.md,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          child: SizedBox(
            height: 300,
            child: FiicoCycleCalendar(
              selectedDays: _selectedDays,
              budget: budget,
              onDaysSelected: (dates) {
                _selectedDays = dates;
              },
            ),
          ),
        ),
        FiicoButton.pink(
          title: 'Seleccionar',
          ontap: () {
            if (_selectedDays.isNotEmpty) {
              onDaySelected(_selectedDays);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  String _getTitle() {
    return 'Selecciona un día';
  }
}
