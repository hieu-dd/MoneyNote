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
  List<Transaction> transactions;
  ChartType type;

  TransactionsBarChart({required this.transactions, required this.type});

  @override
  State<TransactionsBarChart> createState() => _TransactionsBarChartState();
}

class _TransactionsBarChartState extends State<TransactionsBarChart> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;
  late List<TransactionChartItem> _chartItems;
  late double _delta;
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    _chartItems = TransactionChartItem.buildFromTransactions(
      widget.transactions,
      widget.type,
    );
    final maxIncome = _chartItems.map((e) => e.income).reduce(max);
    final maxExpensive = _chartItems.map((e) => e.expensive).reduce(max);
    _delta = max(maxIncome, maxExpensive) / 19;
    rawBarGroups = _chartItems.map((e) {
      var index = _chartItems.indexOf(e);
      return makeGroupData(index, e.income / _delta, e.expensive / _delta);
    }).toList();
    showingBarGroups = rawBarGroups;

    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                  makeTransactionsIcon(),
                  const SizedBox(
                    width: 38,
                  ),
                  const Text(
                    'Transactions',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Text(
                    'state',
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 38,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: 500,
                    height: double.infinity,
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
                                      showingBarGroups[touchedGroupIndex]
                                          .copyWith(
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
                                    _chartItems.map((e) => e.title).toList();
                                return bottomTitles(titles, value, meta);
                              },
                              reservedSize: 42,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    if (value % 4 == 0) {
      return Text((value * _delta).formatMoney(), style: style);
    } else {
      return Container();
    }
  }

  Widget bottomTitles(List<String> titles, double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text = Text(
      titles[value.toInt()],
      style: style,
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

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
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

  static List<TransactionChartItem> buildFromTransactions(
    List<Transaction> transactions,
    ChartType type,
  ) {
    final times = transactions.map((e) => e.time).toList()..sort();
    List<DateTime> uniqueTimes;
    switch (type) {
      case ChartType.day:
        uniqueTimes = times.unique((t) => "${t.day}${t.month}${t.year}");
        break;
      case ChartType.month:
        uniqueTimes = times.unique((t) => "${t.month}${t.year}");
        break;
      default:
        uniqueTimes = times.unique((t) => "${t.year}");
    }
    return uniqueTimes.map((time) {
      String title;
      double income;
      double expensive;
      switch (type) {
        case ChartType.day:
          title = "${time.day}/${time.month}";
          expensive = transactions
              .where((element) => element.time.isSameDay(time))
              .fold(0, (previous, current) => previous + current.amount);
          income = 0;
          break;
        case ChartType.month:
          title = "${time.month}/${time.year}";
          expensive = transactions
              .where((element) => element.time.isSameMonth(time))
              .fold(0, (previous, current) => previous + current.amount);
          income = 0;
          break;
        default:
          title = "${time.day}/${time.month}";
          expensive = transactions
              .where((element) => element.time.year == time.year)
              .fold(0, (previous, current) => previous + current.amount);
          income = 0;
      }
      return TransactionChartItem(
        title: title,
        income: income,
        expensive: expensive,
      );
    }).toList();
  }
}

enum ChartType {
  day,
  month,
  year,
}
