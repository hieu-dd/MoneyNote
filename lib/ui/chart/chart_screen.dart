import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/widgets/chart/bar_chart.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:money_note/utils/ext/list_ext.dart';
import 'package:money_note/utils/ext/time_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../models/transaction/transaction.dart';
import 'package:money_note/utils/ext/string_ext.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/chart/pie_chart.dart';
import '../../widgets/empty_transactions.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Map<String, DateTime> timeRange = {
    "start": DateTime.now().getFirstDayInMonth(),
    "end": DateTime.now().getLastDayInMonth(),
  };

  void _onChangeTime(DateTime date) {
    setState(() {
      timeRange = {
        "start": date.getFirstDayInMonth(),
        "end": date.getLastDayInMonth(),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsProvider = context.watch<TransactionsProvider>();
    final transactions = transactionsProvider.getTransactionsByTime(timeRange);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: moneyAppbar(
        context: context,
        balance: transactionsProvider.getSpentAmountByTime(),
      ),
      body: transactions.isEmpty
          ? emptyTransactions(context)
          : Container(
              padding: const EdgeInsets.all(10),
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'common.income_expensive'.tr().capitalize(),
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'common.net_income'.tr().capitalize(),
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    transactionsProvider.getSpentAmountByTime().formatMoney(),
                    style: theme.textTheme.headlineSmall,
                  ),
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      child: TransactionsBarChart(
                        chartItems: buildFromTransactions(
                          transactions,
                          ChartType.day,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: _PieChartDetail(
                            transactions: [],
                            title: 'common.income'.tr().capitalize(),
                            isIncome: true,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: _PieChartDetail(
                            transactions: transactions,
                            title: 'common.expensive'.tr().capitalize(),
                            isIncome: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _PieChartDetail extends StatelessWidget {
  final List<Transaction> transactions;
  final String title;
  final bool isIncome;

  _PieChartDetail({
    required this.transactions,
    required this.title,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double spent = transactions.fold(
        0, (previousValue, element) => previousValue + element.amount);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          spent.formatMoney(),
          style: textTheme.titleLarge
              ?.copyWith(color: isIncome ? Colors.blue : Colors.redAccent),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 100,
          child: transactions.isEmpty
              ? SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    child: const SizedBox(
                      height: 75,
                      width: 75,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: SizedBox(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                          ),
                          width: 65,
                          height: 65,
                        ),
                      ),
                    ),
                  ),
                )
              : Transform.scale(
                  child: TransactionsPieChart(
                    items: buildPiesFromTransactions(transactions),
                  ),
                  scale: 0.5,
                ),
        ),
      ],
    );
  }
}

List<TransactionChartItem> buildFromTransactions(
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
        income = 10;
        break;
      case ChartType.month:
        title = "${time.month}/${time.year}";
        expensive = transactions
            .where((element) => element.time.isSameMonth(time))
            .fold(0, (previous, current) => previous + current.amount);
        income = 10;
        break;
      default:
        title = "${time.day}/${time.month}";
        expensive = transactions
            .where((element) => element.time.year == time.year)
            .fold(0, (previous, current) => previous + current.amount);
        income = 10;
    }
    return TransactionChartItem(
      title: title,
      income: expensive.abs() / 250, // TODO
      expensive: expensive.abs(),
    );
  }).toList();
}

List<TransactionPieCharItem> buildPiesFromTransactions(
    List<Transaction> transactions) {
  Map<String, double> categoriesValue =
      transactions.fold({}, (previousValue, element) {
    if (previousValue.containsKey(element.categoryId)) {
      return previousValue
        ..[element.categoryId] =
            previousValue[element.categoryId]! + element.amount;
    } else {
      return previousValue..[element.categoryId] = element.amount;
    }
  });

  double total =
      transactions.fold(0, (previous, current) => previous + current.amount);
  return categoriesValue
      .map((key, value) => MapEntry(
          key,
          TransactionPieCharItem(
            value: value * 100 ~/ total,
            categoryId: key,
          )))
      .values
      .toList();
}
