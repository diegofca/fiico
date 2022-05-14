import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_calendar.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:flutter/material.dart';

class CreateMovementDatesSelectorView {
  void show(
    BuildContext context, {
    List<Timestamp>? selectedDates,
    required Budget? budget,
    required Function(List<Timestamp>) onDatesSelected,
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
                  selectedDates,
                  onDatesSelected,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _datePicker(
      BuildContext context,
      Budget? budget,
      List<Timestamp>? selectedDates,
      Function(List<Timestamp>) onDatesSelected) {
    var _selectedDates = selectedDates ?? [];
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
            child: FiicoUniqueCalendar(
              selectedDates: _selectedDates.map((e) => e.toDate()).toList(),
              budget: budget,
              onDatesSelected: (dates) {
                _selectedDates =
                    dates.map((e) => Timestamp.fromDate(e)).toList();
              },
            ),
          ),
        ),
        FiicoButton.pink(
          title: FiicoLocale.selectButton,
          ontap: () {
            if (_selectedDates.isNotEmpty) {
              onDatesSelected(_selectedDates);
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }

  String _getTitle() {
    return FiicoLocale.selectAday;
  }
}
