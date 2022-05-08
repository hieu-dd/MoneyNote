import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:provider/provider.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final transactionsProvider = context.watch<TransactionsProvider>();

    return Scaffold(
      body: Column(
        children:
            transactionsProvider.transactions.map((e) => Text(e.note)).toList(),
      ),
    );
  }
}
