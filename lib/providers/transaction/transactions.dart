import 'package:flutter/material.dart';
import 'package:money_note/models/transaction/transaction.dart';
import 'package:money_note/utils/ext/time_ext.dart';
import 'package:hive/hive.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as CloudFireStore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_note/utils/ext/list_ext.dart';

class TransactionsProvider with ChangeNotifier {
  final _fireStore = CloudFireStore.FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final List<Transaction> _transactions = [];

  List<Transaction> get transactions {
    if (_transactions.isEmpty) {
      syncTransactions();
    }
    return _transactions;
  }

  syncTransactions() async {
    final List<Transaction> localData = [];
    final List<Transaction> remoteData = [];

    final _transactionsBox = Hive.box("transactions");
    for (var e in _transactionsBox.values) {
      localData.add(e);
    }
    final _user = _auth.currentUser;
    if (_user != null) {
      final tranRefs = _fireStore
          .collection("users")
          .doc(_user.uid)
          .collection("transactions");
      final data = await tranRefs.get();
      for (var element in data.docs) {
        remoteData.add(Transaction.fromFirestore(element));
      }
    }
    final fullTransactions = [...localData, ...remoteData].unique((e) => e.id);
    _transactions.addAll(fullTransactions);
    if (_transactions.isNotEmpty) {
      notifyListeners();
    }
    // Sync local and remote
    final missingLocal = fullTransactions
        .where((element) => !localData.map((e) => e.id).contains(element.id));
    for (var element in missingLocal) {
      saveToLocal(element);
    }

    final missingRemote = fullTransactions
        .where((element) => !remoteData.map((e) => e.id).contains(element.id));
    for (var element in missingRemote) {
      saveToRemote(element);
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
    _transactions.add(transaction);
    saveToRemote(transaction);
    saveToLocal(transaction);
    notifyListeners();
  }

  void saveToLocal(Transaction transaction) {
    final _transactionsBox = Hive.box("transactions");
    _transactionsBox.add(transaction);
  }

  void saveToRemote(Transaction transaction) {
    final _user = _auth.currentUser;
    if (_user != null) {
      final collections = _fireStore.collection("users");
      collections
          .doc(_user.uid)
          .collection("transactions")
          .doc(transaction.id)
          .set(transaction.toFirestore());
    }
  }
}
