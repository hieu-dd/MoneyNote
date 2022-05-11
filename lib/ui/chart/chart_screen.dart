import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/widgets/chart/bar_chart.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/double_ext.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsProvider = context.watch<TransactionsProvider>();
    return Scaffold(
      body: Column(
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
          if (transactionsProvider.transactions.isNotEmpty)
            TransactionsBarChart(
              transactions: transactionsProvider.transactions,
              type: ChartType.day,
            ),
          Test(
            text: transactionsProvider.transactions.length.toString(),
          )
        ],
      ),
    );
  }
}

class Test extends StatefulWidget {
  final String text;

  Test({required this.text});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late String text;

  @override
  Widget build(BuildContext context) {
    text = widget.text;
    return Container(
      child: Text(text),
    );
  }
}
