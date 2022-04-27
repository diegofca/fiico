// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class FiicoUniqueCalendar extends StatefulWidget {
  FiicoUniqueCalendar({
    Key? key,
    this.selectedDates = const [],
    required this.onDatesSelected,
    required this.budget,
  }) : super(key: key);

  List<DateTime>? selectedDates;
  final Function(List<DateTime>) onDatesSelected;

  final Budget? budget;

  @override
  State<FiicoUniqueCalendar> createState() => FiicoMovementCalendarState();
}

class FiicoMovementCalendarState extends State<FiicoUniqueCalendar> {
  @override
  Widget build(BuildContext context) {
    return buildWeekDatePicker();
  }

  Widget buildWeekDatePicker() {
    return DayPicker.multi(
      selectedDates: _getDates() ?? [],
      firstDate: _getInitialDate(),
      lastDate: _getFinalDate(),
      selectableDayPredicate: _getPredicate,
      onChanged: onChanged,
      eventDecorationBuilder: (date) {
        return const EventDecoration(
          textStyle: Style.subtitle,
        );
      },
      datePickerStyles: _style,
      datePickerLayoutSettings: const DatePickerLayoutSettings(
        hideMonthNavigationRow: true,
        contentPadding: EdgeInsets.zero,
        dayPickerRowHeight: 50,
      ),
    );
  }

  //General functions
  void onChanged(List<DateTime> dates) {
    setState(() {
      widget.selectedDates = dates;
      widget.onDatesSelected(dates);
    });
  }

  List<DateTime>? _getDates() {
    return widget.selectedDates;
  }

  bool _getPredicate(DateTime date) {
    return true;
  }

  //Configuration vars/ functions
  DateTime _getInitialDate() {
    return widget.budget?.startDate?.toDate() ?? DateTime.now();
  }

  DateTime _getFinalDate() {
    return widget.budget?.finishDate?.toDate() ?? DateTime.now();
  }

  DatePickerRangeStyles get _style => DatePickerRangeStyles(
        selectedSingleDateDecoration: const BoxDecoration(
          color: FiicoColors.purpleNeutral,
          shape: BoxShape.circle,
        ),
        disabledDateStyle: Style.subtitle.copyWith(
          color: FiicoColors.graySoft,
        ),
        selectedDateStyle: Style.subtitle.copyWith(
          color: FiicoColors.white,
          fontWeight: FiicoFontWeight.bold,
        ),
      );
}
