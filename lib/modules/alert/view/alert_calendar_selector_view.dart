import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';

class AlertCalendarSelectorView extends StatelessWidget {
  const AlertCalendarSelectorView({
    Key? key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
  }) : super(key: key);

  final DateTime initialDateTime;
  final Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return DayPicker.single(
      selectedDate: initialDateTime,
      firstDate: _getInitialDate(),
      lastDate: _getFinalDate(),
      // selectableDayPredicate: _getPredicate,
      onChanged: onDateTimeChanged,
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

  // bool _getPredicate(DateTime date) {
  //   switch (widget.cycle) {
  //     case BudgetCycleType.TWO_WEEKS:
  //       final nextDay = initialDateTime.add(const Duration(days: 14));
  //       if (initdate == null) {
  //         return date.day <= 16;
  //       }
  //       return date.day == initdate.day || date.day == nextDay?.day;
  //     default:
  //       return true;
  //   }
  // }

  //Configuration vars/ functions
  DateTime _getInitialDate() {
    return DateTime(DateTime.now().year, DateTime.now().month, 1);
  }

  DateTime _getFinalDate() {
    return DateTime(DateTime.now().year,
        DateTime.now().add(const Duration(days: 30)).month, 1);
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
