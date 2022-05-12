import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/widgets/chart/bar_chart.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:money_note/utils/ext/list_ext.dart';
import 'package:money_note/utils/ext/time_ext.dart';
import '../../models/transaction/transaction.dart';
import '../../widgets/chart/pie_chart.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsProvider = context.watch<TransactionsProvider>();
    final transactions = transactionsProvider.transactions;
    return Scaffold(
      backgroundColor: Colors.white,
      body: transactions.isEmpty
          ? emptyTransactions()
          : Container(
              padding: const EdgeInsets.all(10),
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Income & Expensive",
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Net Income",
                    style: theme.textTheme.bodySmall,
                  ),
                  Text(
                    transactionsProvider.spentAmount.formatMoney(),
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
                          child: _PieChartDetail(),
                        ),
                        Flexible(
                          flex: 1,
                          child: _PieChartDetail(),
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Expensive"),
        Text(100000.0.formatMoney()),
        Expanded(
          child: Transform.scale(
            child: TransactionsPieChart(),
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
        income = expensive;
        break;
      case ChartType.month:
        title = "${time.month}/${time.year}";
        expensive = transactions
            .where((element) => element.time.isSameMonth(time))
            .fold(0, (previous, current) => previous + current.amount);
        income = expensive;
        break;
      default:
        title = "${time.day}/${time.month}";
        expensive = transactions
            .where((element) => element.time.year == time.year)
            .fold(0, (previous, current) => previous + current.amount);
        income = expensive;
    }
    return TransactionChartItem(
      title: title,
      income: income,
      expensive: expensive,
    );
  }).toList();
}

Widget emptyTransactions() {
  return Center(
    child: Icon(Icons.add_outlined),
  );
}
