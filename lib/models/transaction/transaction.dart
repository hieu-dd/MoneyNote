import 'package:money_note/models/category/category.dart';
import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  double amount;
  @HiveField(1)
  String categoryId;
  @HiveField(2)
  String note;
  @HiveField(3)
  DateTime time;

  Transaction({
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.time,
  });
}
