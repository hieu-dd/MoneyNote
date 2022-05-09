import 'package:money_note/models/transaction/transaction.dart';

class TransactionItem {
  late String id;
  final Type type;
  final DateTime time;
  final Transaction? transaction;

  TransactionItem({
    this.type = Type.transaction,
    required this.time,
    this.transaction,
  }) {
    id = time.hashCode.toString() + transaction.hashCode.toString();
  }
}

enum Type { header, transaction }
