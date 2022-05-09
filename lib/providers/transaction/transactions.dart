import 'package:flutter/material.dart';
import 'package:money_note/models/transaction/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  double get spentAmount =>
      transactions.fold(0, (previous, current) => previous + current.amount);

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
