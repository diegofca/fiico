import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/models/alert.dart';
import 'package:control/modules/alert/bloc/alert_selector_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AlertSelectorView {
  void show(
    BuildContext context, {
    FiicoAlert? alert,
    required Function(FiicoAlert) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => AlertSelectorBloc(),
          child: _blocView(context, alert, onSelected),
        );
      },
    );
  }

  Widget _blocView(BuildContext context, FiicoAlert? alert,
      Function(FiicoAlert) onSelected) {
    return BlocBuilder<AlertSelectorBloc, AlertSelectorState>(
      builder: (context, state) {
        switch (state.status) {
          case AlertSelectorStatus.waiting:
          case AlertSelectorStatus.addedLoading:
            return _bodySelector(context, alert, onSelected);
        }
      },
    );
  }

  Widget _bodySelector(BuildContext context, FiicoAlert? alert,
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
            child: _datePicker(context, alert, onSelected),
          ),
        );
      },
    );
  }

  Widget _datePicker(BuildContext context, FiicoAlert? alert,
      Function(FiicoAlert) onSelected) {
    final state = context.read<AlertSelectorBloc>().state;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dateTitleView(),
        _intensiveSwitchPicker(context, alert, state.isIntensive),
        _datePickerView(context, alert, state.date),
        _selecteButton(context, alert, onSelected),
      ],
    );
  }

  Widget _dateTitleView() {
    return Text(
      "Agregar fecha de notificación",
      style: Style.title.copyWith(
        fontSize: FiicoFontSize.md,
      ),
    );
  }

  Widget _intensiveSwitchPicker(
      BuildContext context, FiicoAlert? alert, bool? isIntensive) {
    final _isIntensive = isIntensive ?? alert?.isIntensive() ?? false;
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
            "Modo intesivo",
            style: Style.subtitle.copyWith(
              fontSize: FiicoFontSize.xm,
            ),
          ),
          IconButton(
            onPressed: () => FiicoAlertDialog.showInfo(
              context,
              title: 'Notifcación modo intensivo',
              message:
                  'Las notificaciones en modo intesivo se activiran a diario una semana antes de la fecha final estipulada, puedes activarlo y desactivarlo en cualquier momento.',
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
      BuildContext context, FiicoAlert? alert, DateTime? _selectedDate) {
    final date = _selectedDate ?? alert?.date?.toDate() ?? DateTime.now();
    return Container(
      margin: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: SizedBox(
        height: 200,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: date,
          onDateTimeChanged: (val) {
            context
                .read<AlertSelectorBloc>()
                .add(AlertSelectorInfoRequest(date: val));
          },
        ),
      ),
    );
  }

  Widget _selecteButton(BuildContext context, FiicoAlert? alert,
      Function(FiicoAlert) onSelected) {
    final state = context.read<AlertSelectorBloc>().state;

    final date = state.date ?? alert?.date?.toDate() ?? DateTime.now();
    final isIntesive = state.isIntensive ?? alert?.isIntensive() ?? false;
    final type =
        isIntesive ? FiicoAlert.INTENSIVE_TYPE : FiicoAlert.SIMPLE_TYPE;

    return FiicoButton.green(
      title: 'Seleccionar',
      ontap: () {
        final alert = FiicoAlert(
          active: true,
          date: Timestamp.fromDate(date),
          type: type,
        );
        onSelected(alert);
        Navigator.of(context).pop();
      },
    );
  }
}
