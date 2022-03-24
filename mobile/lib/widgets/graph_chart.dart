import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../translations/locale_keys.g.dart';
import '../screens/home_page/components/no_data_text.dart';
import '../config/size_config.dart';
import '../constants/constants.dart';

class GraphChart extends StatelessWidget {
  final transactions;
  final graphController;
  final bool isDayHere;
  final bool isWeekHere;
  final bool isMonthHere;
  GraphChart({
    Key? key,
    this.transactions,
    this.graphController,
    this.isDayHere = true,
    this.isWeekHere = true,
    this.isMonthHere = true,
  }) : super(key: key);

  final List<double> months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  double get amoutForY {
    months.sort((a, b) => a.compareTo(b));
    List<double> array = [];
    transactions.forEach((tx) {
      array.add(tx.amount);
    });
    int size = array.length;
    array.sort();
    if (size == 0) return 0.0;
    return array[size - 1];
  }

  double get days {
    int _temp1 = 0;
    int _temp2 = 0;
    double x = 0.0;
    transactions.forEach((tx) {
      _temp1 = tx.dateTime!.month;
      _temp2 = tx.dateTime!.day;
      for (int i = 0; i < _temp1; i++) {
        x += months[i];
      }
      x += _temp2;
    });
    return x;
  }

  List<FlSpot> getIt() {
    List<FlSpot> _temp = [];
    double b = -0.1;
    for (int i = 0; i < transactions.length; i++) {
      if (graphController == GraphController.DAY) b = 1;
      _temp.add(FlSpot(i + b, transactions[i].amount));
      b = 0.0;
    }
    return _temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getPropotionalScreenHeight(225),
      width: double.infinity,
      child: (graphController == GraphController.DAY &&
              transactions.length <= 1)
          ? NoDataText(LocaleKeys.not_enough_data_for_graph.tr())
          : (graphController == GraphController.WEEK &&
                  transactions.length <= 1)
              ? NoDataText(LocaleKeys.not_enough_data_for_graph.tr())
              : (graphController == GraphController.MONTH &&
                      transactions.length <= 1)
                  ? NoDataText(LocaleKeys.not_enough_data_for_graph.tr())
                  : LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(show: false),
                        minX: 0,
                        maxX: graphController == GraphController.DAY
                            ? transactions.length + 1.0
                            : transactions.length + -1.0,
                        minY: graphController == GraphController.DAY ? 0 : -50,
                        maxY: graphController == GraphController.DAY
                            ? amoutForY + 5
                            : amoutForY + 50,
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            belowBarData: BarAreaData(
                              show: true,
                              colors: [
                                kPurple100.withOpacity(.8),
                                kPurple100.withOpacity(.5),
                                kPurple100.withOpacity(.4),
                                kPurple100.withOpacity(.2),
                                kPurple100.withOpacity(.2),
                                kPurple100.withOpacity(0),
                              ],
                              gradientFrom: Offset(0.0, -0.2),
                              gradientTo: Offset(0, 1),
                            ),
                            dotData: FlDotData(
                              show: graphController == GraphController.DAY
                                  ? true
                                  : false,
                            ),
                            spots: getIt(),
                            isCurved: true,
                            colors: [kPurple100],
                            barWidth: 5,
                          ),
                        ],
                      ),
                      swapAnimationDuration: Duration(milliseconds: 300),
                      swapAnimationCurve: Curves.linearToEaseOut,
                    ),
    );
  }
}
