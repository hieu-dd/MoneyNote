import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/chart/chart_content.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/time_ext.dart';
import '../../widgets/app_bar.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  var _dateTimeType = DateTimeType.month;

  void _onChangeDateTimeType(DateTimeType type) {
    setState(() {
      _dateTimeType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionsProvider = context.watch<TransactionsProvider>();
    const timeLength = 12;
    return DefaultTabController(
      initialIndex: timeLength - 1,
      length: timeLength,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: moneyAppbar(
          context: context,
          balance: transactionsProvider.getSpentAmountByTime(),
          changeRange: _onChangeDateTimeType,
          timeLength: timeLength,
          timeType: _dateTimeType,
        ),
        body: TabBarView(
          children: List.generate(timeLength, (index) => timeLength - 1 - index)
              .map((e) => _tabContent(e, _dateTimeType))
              .toList(),
        ),
      ),
    );
  }
}

Widget _tabContent(int unit, DateTimeType type) {
  final timeRange = DateTime.now().calTimeRange(unit, type);
  return ChartContent(timeRange: timeRange);
}
