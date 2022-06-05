import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/transactions/transaction_content.dart';
import 'package:money_note/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/time_ext.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  var _dateTimeType = DateTimeType.month;

  void _onChangeDateTimeType(DateTimeType type) {
    setState(() {
      _dateTimeType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionsProvider = context.watch<TransactionsProvider>();
    final timeLength = _dateTimeType == DateTimeType.day
        ? 30
        : _dateTimeType == DateTimeType.year
            ? 5
            : 12;
    return DefaultTabController(
      initialIndex: timeLength - 1,
      length: timeLength,
      child: Scaffold(
        appBar: moneyAppbar(
          context: context,
          balance: transactionsProvider.getSpentAmountByTime(),
          changeRange: _onChangeDateTimeType,
          timeLength: timeLength,
          timeType: _dateTimeType,
        ),
        body: TabBarView(
          children: List.generate(timeLength, (index) => timeLength - 1 - index)
              .map((e) => tabContent(e, _dateTimeType))
              .toList(),
        ),
      ),
    );
  }
}

Widget tabContent(int unit, DateTimeType type) {
  final timeRange = DateTime.now().calTimeRange(unit, type);
  return TransactionContent(timeRange: timeRange);
}
