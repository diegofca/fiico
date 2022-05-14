// ignore_for_file: constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/indicator.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/budget_cycle_history.dart';
import 'package:control/modules/budgetDetail/bloc/budget_detail_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum BudgetChartCircleSections {
  TOTAL_PAY,
  TOTAL_RECEIVED,
  PEDING_PAY,
  PENDING_RECEIVED
}

class BudgetChartCircleView extends StatefulWidget {
  const BudgetChartCircleView({
    Key? key,
    required this.budget,
    required this.width,
    this.dropdownvalue = 0,
  }) : super(key: key);

  final Budget budget;
  final double width;
  final int? dropdownvalue;

  @override
  State<BudgetChartCircleView> createState() => BudgetChartCircleViewState();
}

class BudgetChartCircleViewState extends State<BudgetChartCircleView> {
  List<BudgetChartCircleSections> sections = [
    BudgetChartCircleSections.TOTAL_PAY,
    BudgetChartCircleSections.TOTAL_RECEIVED,
    BudgetChartCircleSections.PEDING_PAY,
    BudgetChartCircleSections.PENDING_RECEIVED,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        children: <Widget>[
          _getPieSections(),
          Row(
            children: [
              _getTitleList(),
              _dropDownFilterView(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getPieSections() {
    return SizedBox(
      width: widget.width,
      height: 200,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 30,
          sections: sections.map((e) => _getSectionData(e)).toList(),
        ),
        swapAnimationCurve: Curves.decelerate,
      ),
    );
  }

  Widget _getTitleList() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: sections
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: FiicoPaddings.two,
                  ),
                  child: Indicator(
                    color: _getColor(e),
                    text: _getTitle(e),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _dropDownFilterView() {
    return DropdownButton(
      value: widget.dropdownvalue,
      underline: Container(),
      alignment: AlignmentDirectional.centerEnd,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: FiicoColors.grayNeutral,
      ),
      style: Style.subtitle.copyWith(
        color: FiicoColors.grayNeutral,
        fontSize: FiicoFontSize.xm,
      ),
      dropdownColor: Colors.white,
      items: _getAllHistorySections().map((item) {
        return DropdownMenuItem<int>(
          alignment: Alignment.centerLeft,
          value: _getAllHistorySections().indexWhere((e) => e.id == item.id),
          child: Text(
            item.titleCircleOption(item.id),
            textAlign: TextAlign.right,
            style: Style.subtitle,
          ),
        );
      }).toList(),
      onChanged: (int? newValue) {
        context
            .read<BudgetDetailBloc>()
            .add(BudgetUpdateDropdownHistoryIndexRequest(index: newValue));
      },
    );
  }

  /// Functions - get generic data

  List<BudgetCycleHistory> _getAllHistorySections() {
    final pendingToDebt = widget.budget.getPendingDebt();
    final pendingToEntry = widget.budget.getPendingEntry();
    final payedToDebt = widget.budget.getPayedDebt();
    final payedToEntry = widget.budget.getPayedEntry();

    final current = BudgetCycleHistory(
      totalPayedDebt: payedToDebt,
      totalPayedEntry: payedToEntry,
      totalPendingDebt: pendingToDebt,
      totalPendingEntry: pendingToEntry,
      date: Timestamp.now(),
    );
    return widget.budget.isEmptyMovements()
        ? widget.budget.histories ?? []
        : [current, ...?widget.budget.histories];
  }

  PieChartSectionData _getSectionData(BudgetChartCircleSections section) {
    const fontSize = 12.0;
    const radius = 45.0;
    return PieChartSectionData(
      color: _getColor(section),
      value: _getValue(section),
      title: _getValuePercentage(section),
      radius: radius,
      titleStyle: Style.subtitle.copyWith(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: FiicoColors.black,
      ),
    );
  }

  String _getTitle(BudgetChartCircleSections section) {
    switch (section) {
      case BudgetChartCircleSections.PEDING_PAY:
        return FiicoLocale.pendingPayable;
      case BudgetChartCircleSections.PENDING_RECEIVED:
        return FiicoLocale.pendingToReceive;
      case BudgetChartCircleSections.TOTAL_PAY:
        return FiicoLocale.totalPaid;
      case BudgetChartCircleSections.TOTAL_RECEIVED:
        return FiicoLocale.totalReceived;
    }
  }

  double _getValue(BudgetChartCircleSections section) {
    final item = _getAllHistorySections()[widget.dropdownvalue ?? 0];

    switch (section) {
      case BudgetChartCircleSections.PEDING_PAY:
        return item.totalPendingDebt?.toDouble() ?? 0;
      case BudgetChartCircleSections.PENDING_RECEIVED:
        return item.totalPendingEntry?.toDouble() ?? 0;
      case BudgetChartCircleSections.TOTAL_PAY:
        return item.totalPayedDebt?.toDouble() ?? 0;
      case BudgetChartCircleSections.TOTAL_RECEIVED:
        return item.totalPayedEntry?.toDouble() ?? 0;
    }
  }

  String _getValuePercentage(BudgetChartCircleSections section) {
    final item = _getAllHistorySections()[widget.dropdownvalue ?? 0];

    switch (section) {
      case BudgetChartCircleSections.PEDING_PAY:
        final total = item.totalPendingDebt?.toDouble() ?? 0;
        return total.toCurrencyCompat();
      case BudgetChartCircleSections.PENDING_RECEIVED:
        final total = item.totalPendingEntry?.toDouble() ?? 0;
        return total.toCurrencyCompat();
      case BudgetChartCircleSections.TOTAL_PAY:
        final total = item.totalPayedDebt?.toDouble() ?? 0;
        return total.toCurrencyCompat();
      case BudgetChartCircleSections.TOTAL_RECEIVED:
        final total = item.totalPayedEntry?.toDouble() ?? 0;
        return total.toCurrencyCompat();
    }
  }

  Color _getColor(BudgetChartCircleSections section) {
    switch (section) {
      case BudgetChartCircleSections.PEDING_PAY:
        return FiicoColors.pink.withOpacity(0.3);
      case BudgetChartCircleSections.PENDING_RECEIVED:
        return FiicoColors.greenNeutral.withOpacity(0.3);
      case BudgetChartCircleSections.TOTAL_PAY:
        return FiicoColors.pink;
      case BudgetChartCircleSections.TOTAL_RECEIVED:
        return FiicoColors.greenNeutral;
    }
  }
}
