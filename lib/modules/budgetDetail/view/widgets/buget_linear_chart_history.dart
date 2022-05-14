import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/budget_cycle_history.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BudgetLinearChartHistory extends StatefulWidget {
  const BudgetLinearChartHistory({
    Key? key,
    required this.budget,
    required this.width,
  }) : super(key: key);

  final Budget budget;
  final double width;

  @override
  State<StatefulWidget> createState() => BudgetLinearChartHistoryState();
}

class BudgetLinearChartHistoryState extends State<BudgetLinearChartHistory> {
  late List<BarChartGroupData> showingBarGroups;
  int poxIndex = -1;

  @override
  void initState() {
    super.initState();
    showingBarGroups = _getAllHistorySections()
        .map((e) => makeGroupData(e.totalPayedDebt, e.totalPayedEntry))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double newWidth = 80 + (showingBarGroups.length * 40);

    return Container(
      width: widget.width > newWidth ? widget.width : newWidth,
      padding: const EdgeInsets.only(top: FiicoPaddings.thirtyTwo),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                '${FiicoLocale.summaryPerCycle}:  ${FiicoLocale.incomes} vs ${FiicoLocale.outcomes}',
                style: Style.subtitle,
              ),
            ],
          ),
          const SizedBox(height: FiicoPaddings.thirtyTwo),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: widget.budget.getTotal(),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: FiicoColors.graySoft,
                    getTooltipItem: (data1, index1, data2, index2) {
                      final option = data2.toY;
                      return BarTooltipItem(
                        option.toCurrencyCompat(),
                        Style.desc.copyWith(
                          color: FiicoColors.grayDark,
                          fontSize: FiicoFontSize.xm,
                        ),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: bottomTitles,
                      reservedSize: 35,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      getTitlesWidget: leftTitles,
                      interval: _getInterval(),
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: showingBarGroups,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: FiicoFontSize.small,
    );
    final valueInMillions = value.toCurrencyCompat();
    return Text(valueInMillions, style: style);
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: Text(
        _getAllHistorySections()[value.toInt()].titleBarOption(),
        style: Style.subtitle.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.xxxs,
        ),
      ),
    );
  }

  /// Functions - get generic dataç

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
        : [current, ...?widget.budget.histories]
      ..sort((a, b) => a.date!.compareTo(b.date!));
  }

  double _getInterval() {
    final newInterval = widget.budget.getTotal() / 4;
    return newInterval;
  }

  BarChartGroupData makeGroupData(num? y1, num? y2) {
    poxIndex = poxIndex + 1;
    return BarChartGroupData(barsSpace: 4, x: poxIndex, barRods: [
      BarChartRodData(
        toY: (y1?.toDouble() ?? 0),
        color: FiicoColors.pink,
        width: 10,
      ),
      BarChartRodData(
        toY: (y2?.toDouble() ?? 0),
        color: FiicoColors.greenNeutral,
        width: 10,
      ),
    ]);
  }
}
