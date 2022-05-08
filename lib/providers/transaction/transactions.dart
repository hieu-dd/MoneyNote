import 'package:flutter/material.dart';
import 'package:money_note/models/category.dart';
import 'package:money_note/models/transaction/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  final List<Transaction> _transactions = [
    Transaction(
      amount: 1000.0,
      category: Category(id: "", name: ""),
      note: "note",
      time: DateTime.now(),
    )
  ];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
