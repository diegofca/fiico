import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_calendar.dart';
import 'package:control/helpers/genericViews/fiico_cycle_calendar.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/alert.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/alert/bloc/alert_selector_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:collection/collection.dart';

class AlertSelectorView {
  void show(
    BuildContext context, {
    Movement? movement,
    required Budget? budget,
    required Function(FiicoAlert) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => AlertSelectorBloc(),
          child: _blocView(context, budget, movement, onSelected),
        );
      },
    );
  }

  Widget _blocView(BuildContext context, Budget? budget, Movement? movement,
      Function(FiicoAlert) onSelected) {
    return BlocBuilder<AlertSelectorBloc, AlertSelectorState>(
      builder: (context, state) {
        switch (state.status) {
          case AlertSelectorStatus.waiting:
          case AlertSelectorStatus.addedLoading:
            return _bodySelector(context, budget, movement, onSelected);
        }
      },
    );
  }

  Widget _bodySelector(BuildContext context, Budget? budget, Movement? movement,
      Function(FiicoAlert) onSelected) {
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
            child: _datePicker(context, budget, movement, onSelected),
          ),
        );
      },
    );
  }

  Widget _datePicker(BuildContext context, Budget? budget, Movement? movement,
      Function(FiicoAlert) onSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dateTitleView(),
        _intensiveSwitchPicker(context, movement?.alert),
        _datePickerView(context, budget, movement),
        _selecteButton(context, movement, onSelected),
      ],
    );
  }

  Widget _dateTitleView() {
    return Text(
      FiicoLocale().addNotificationDate,
      style: Style.title.copyWith(
        fontSize: FiicoFontSize.md,
      ),
    );
  }

  Widget _intensiveSwitchPicker(BuildContext context, FiicoAlert? alert) {
    final state = context.read<AlertSelectorBloc>().state;
    final _isIntensive = state.isIntensive ?? alert?.isIntensive() ?? false;
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.thirtyTwo,
        left: FiicoPaddings.thirtyTwo,
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            FiicoLocale().intensiveMode,
            style: Style.subtitle.copyWith(
              fontSize: FiicoFontSize.xm,
            ),
          ),
          IconButton(
            onPressed: () => FiicoAlertDialog.showInfo(
              context,
              title: FiicoLocale().intensiveNotification,
              message: FiicoLocale().intensiveNotificationMsg,
            ),
            icon: const Icon(MdiIcons.information),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: Switch.adaptive(
                value: _isIntensive,
                activeColor: FiicoColors.pink,
                onChanged: (value) {
                  context
                      .read<AlertSelectorBloc>()
                      .add(AlertSelectorInfoRequest(isIntensive: value));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePickerView(
      BuildContext context, Budget? budget, Movement? movement) {
    final state = context.read<AlertSelectorBloc>().state;
    final isCycle = budget?.isCycle ?? false;

    final date = state.day ??
        movement?.alert?.day ??
        movement?.recurrencyAt?.firstOrNull ??
        1;
    final dates = state.dates ??
        movement?.alert?.dates ??
        movement?.recurrencyDates?.map((e) => e.toDate()).toList() ??
        [];

    return Container(
      margin: const EdgeInsets.only(top: FiicoPaddings.eight),
      child: SizedBox(
        height: 240,
        child: isCycle
            ? FiicoCycleCalendar(
                selectedDays: [date],
                budget: budget,
                onDaysSelected: (val) {
                  context
                      .read<AlertSelectorBloc>()
                      .add(AlertSelectorInfoRequest(day: val.first));
                },
              )
            : FiicoUniqueCalendar(
                selectedDates: dates,
                onDatesSelected: (dates) {
                  context
                      .read<AlertSelectorBloc>()
                      .add(AlertSelectorInfoRequest(dates: dates));
                },
                budget: budget,
              ),
      ),
    );
  }

  Widget _selecteButton(BuildContext context, Movement? movement,
      Function(FiicoAlert) onSelected) {
    final state = context.read<AlertSelectorBloc>().state;

    final day = state.day ?? movement?.alert?.day ?? 1;
    final isIntesive =
        state.isIntensive ?? movement?.alert?.isIntensive() ?? false;
    final type =
        isIntesive ? FiicoAlert.INTENSIVE_TYPE : FiicoAlert.SIMPLE_TYPE;

    final dates = state.dates ?? movement?.alert?.dates ?? [];

    return FiicoButton.pink(
      title: FiicoLocale().selectButton,
      ontap: () {
        final alert = FiicoAlert(
          active: true,
          dates: dates,
          day: day,
          type: type,
        );
        onSelected(alert);
        Navigator.of(context).pop();
      },
    );
  }
}
