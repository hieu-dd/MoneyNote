import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/models/transaction/transaction.dart';
import 'package:money_note/utils/ext/time_ext.dart';
import 'package:hive/hive.dart';

class TransactionsProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    if (_transactions.isEmpty) {
      getBoxTransactions();
    }
    return _transactions;
  }

  getBoxTransactions() {
    final _transactionsBox = Hive.box("transactions");
    final values = _transactionsBox.values;

    for (var element in values) {
      _transactions.add(element);
    }
    if (_transactions.isNotEmpty) {
      notifyListeners();
    }
  }

  double get spentAmount =>
      _transactions.fold(0, (previous, current) => previous + current.amount);

  double spentDay(DateTime time) => _transactions.fold(0, (previous, current) {
        if (current.time.isSameDay(time)) {
          return previous + current.amount;
        } else {
          return previous;
        }
      });

  void addTransaction(Transaction transaction) {
    final _transactionsBox = Hive.box("transactions");
    _transactions.add(transaction);
    _transactionsBox.add(transaction);
    notifyListeners();
  }
}
