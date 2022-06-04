import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/transactions/transaction_content.dart';
import 'package:money_note/ui/transactions/transaction_item.dart';
import 'package:money_note/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:money_note/models/transaction/transaction.dart';
import 'package:intl/intl.dart';
import 'package:money_note/utils/ext/list_ext.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../providers/category/categories.dart';
import '../../widgets/empty_transactions.dart';
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
    final length = List.of([11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0]);
    return DefaultTabController(
      initialIndex: 5,
      length: length.length,
      child: Scaffold(
        appBar: moneyAppbar(
          context: context,
          balance: transactionsProvider.getSpentAmountByTime(),
          changeRange: _onChangeDateTimeType,
          bottom: TabBar(
              isScrollable: true,
              tabs: length
                  .map((e) => Tab(child: tabItem(e, _dateTimeType)))
                  .toList()),
        ),
        body: TabBarView(
          children: length.map((e) => tabContent(e, _dateTimeType)).toList(),
        ),
      ),
    );
  }
}

Widget tabItem(int unit, DateTimeType type) {
  final timeRange = DateTime.now().calTimeRange(unit, type);
  String label;
  switch (type) {
    case DateTimeType.day:
      if (unit == 0) {
        label = "Today";
      } else if (unit == 1) {
        label = "Yesterday";
      } else {
        label = DateFormat('dd MMMM yyyy').format(timeRange["start"]!);
      }
      break;
    case DateTimeType.week:
      if (unit == 0) {
        label = "This week";
      } else if (unit == 1) {
        label = "Last week";
      } else {
        label = "${DateFormat('dd/MM').format(timeRange["start"]!)} - "
            "${DateFormat('dd/MM').format(timeRange["end"]!)}";
      }
      break;
    case DateTimeType.month:
      if (unit == 0) {
        label = "This month";
      } else if (unit == 1) {
        label = "Last month";
      } else {
        label = DateFormat('MMMM yyyy').format(timeRange["start"]!);
      }
      break;
    default:
      if (unit == 0) {
        label = "This year";
      } else if (unit == 1) {
        label = "Last year";
      } else {
        label = DateFormat('yyyy').format(timeRange["start"]!);
      }
  }
  return Text(
    label,
    style: TextStyle(color: Colors.black),
  );
}

Widget tabContent(int unit, DateTimeType type) {
  final timeRange = DateTime.now().calTimeRange(unit, type);
  return TransactionContent(timeRange: timeRange);
}
