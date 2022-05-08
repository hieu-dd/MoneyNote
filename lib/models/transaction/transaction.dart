import 'package:money_note/models/category/category.dart';

class Transaction {
  double amount;
  Category category;
  String note;
  DateTime time;

  Transaction({
    required this.amount,
    required this.category,
    required this.note,
    required this.time,
  });
}
