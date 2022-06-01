// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/cycle.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:collection/collection.dart';

class FiicoCycleCalendar extends StatefulWidget {
  FiicoCycleCalendar({
    Key? key,
    this.selectedDays = const [],
    required this.onDaysSelected,
    required this.budget,
  }) : super(key: key);

  List<int>? selectedDays;
  final Function(List<int>) onDaysSelected;
  final Budget? budget;

  @override
  State<FiicoCycleCalendar> createState() => FiicoCycleCalendarState();
}

class FiicoCycleCalendarState extends State<FiicoCycleCalendar> {
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
    final typeCycle = widget.budget?.getCycleType();
    var _dates = dates.map((e) => e.day).toList();
    switch (typeCycle) {
      case BudgetCycleType.MONTH:
        final lastDay = _dates.lastOrNull;
        if (lastDay != null) {
          _dates = [lastDay];
        }
        break;
      default:
        break;
    }
    setState(() {
      widget.selectedDays = _dates;
      widget.onDaysSelected(_dates);
    });
  }

  List<DateTime>? _getDates() {
    return widget.selectedDays
        ?.map(
            (date) => DateTime(DateTime.now().year, DateTime.now().month, date))
        .toList();
  }

  bool _getPredicate(DateTime date) {
    final typeCycle = widget.budget?.getCycleType();
    switch (typeCycle) {
      case BudgetCycleType.TWO_WEEKS:
        final initdate = _getDates()?.firstOrNull;
        final nextDay = initdate?.add(const Duration(days: 14));
        if (initdate == null) {
          return date.day <= 16;
        }
        return date.day == initdate.day || date.day == nextDay?.day;
      default:
        return true;
    }
  }

  //Configuration vars/ functions
  DateTime _getInitialDate() {
    return DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  DateTime _getFinalDate() {
    return DateTime(DateTime.now().year, DateTime.now().month, 31);
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
