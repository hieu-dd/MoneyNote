import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import '../../models/transaction/transaction.dart';
import 'package:money_note/utils/ext/list_ext.dart';
import 'package:money_note/utils/ext/time_ext.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class TransactionsBarChart extends StatefulWidget {
  List<TransactionChartItem> chartItems;

  TransactionsBarChart({required this.chartItems});

  @override
  State<TransactionsBarChart> createState() => _TransactionsBarChartState();
}

class _TransactionsBarChartState extends State<TransactionsBarChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 10;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late double _delta;
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final maxIncome = widget.chartItems.map((e) => e.income).reduce(max);
    final maxExpensive = widget.chartItems.map((e) => e.expensive).reduce(max);
    _delta = max(maxIncome, maxExpensive) / 20;
    _delta = calDelta(max(maxIncome, maxExpensive));
    rawBarGroups = widget.chartItems.map((e) {
      var index = widget.chartItems.indexOf(e);
      return makeGroupData(index, e.income / _delta, e.expensive / _delta);
    }).toList();
    showingBarGroups = rawBarGroups;

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: 20,
                    barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (_a, _b, _c, _d) => null,
                        ),
                        touchCallback: (FlTouchEvent event, response) {
                          if (response == null || response.spot == null) {
                            setState(() {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                            });
                            return;
                          }

                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;

                          setState(() {
                            if (!event.isInterestedForInteractions) {
                              touchedGroupIndex = -1;
                              showingBarGroups = List.of(rawBarGroups);
                              return;
                            }
                            showingBarGroups = List.of(rawBarGroups);
                            if (touchedGroupIndex != -1) {
                              var sum = 0.0;
                              for (var rod
                                  in showingBarGroups[touchedGroupIndex]
                                      .barRods) {
                                sum += rod.toY;
                              }
                              final avg = sum /
                                  showingBarGroups[touchedGroupIndex]
                                      .barRods
                                      .length;

                              showingBarGroups[touchedGroupIndex] =
                                  showingBarGroups[touchedGroupIndex].copyWith(
                                barRods: showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .map((rod) {
                                  return rod.copyWith(toY: avg);
                                }).toList(),
                              );
                            }
                          });
                        }),
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
                          getTitlesWidget: (value, meta) {
                            final titles =
                                widget.chartItems.map((e) => e.title).toList();
                            return bottomTitles(titles, value, meta);
                          },
                          reservedSize: 42,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.5,
                          style: BorderStyle.solid,
                        )),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(
                      checkToShowHorizontalLine: (value) => true,
                      show: true,
                      drawVerticalLine: false,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    if (value % 5 == 0) {
      return Text((value * _delta).formatMoney(), style: style);
    } else {
      return Container();
    }
  }

  Widget bottomTitles(List<String> titles, double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.normal,
      fontSize: 14,
    );
    Widget text = Transform.rotate(
      angle: -0.9,
      child: Text(
        titles[value.toInt()],
        style: style,
      ),
    );

    return Padding(padding: const EdgeInsets.only(top: 20), child: text);
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        toY: y1,
        color: leftBarColor,
        width: width,
      ),
      BarChartRodData(
        toY: y2,
        color: rightBarColor,
        width: width,
      ),
    ]);
  }
}

class TransactionChartItem {
  String title;
  double income;
  double expensive;

  TransactionChartItem({
    required this.title,
    required this.income,
    required this.expensive,
  });
}

enum ChartType {
  day,
  month,
  year,
}

double calDelta(double max) {
  final x = max.toInt().toString().length;
  final delta = 5 * pow(10, x - 2).toInt();
  final newMax = round(max / delta) * delta;
  return newMax / 20;
}

int round(double value) {
  if (value % 1 == 0) {
    return value.round();
  } else {
    return value.round() + 1;
  }
}
