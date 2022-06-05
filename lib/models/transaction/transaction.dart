import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

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
  @HiveField(4)
  String id;

  Transaction({
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.time,
    required this.id,
  });

  Transaction.autoId({
    required this.amount,
    required this.categoryId,
    required this.note,
    required this.time,
  }) : id = const Uuid().v1();

  Map<String, dynamic> toFirestore() {
    return {
      "amount": amount,
      "categoryId": categoryId,
      "note": note,
      "time": time,
    };
  }

  Transaction.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  )   : amount = snapshot.data()?["amount"],
        categoryId = snapshot.data()?["categoryId"],
        note = snapshot.data()?["note"],
        time = (snapshot.data()?["time"] as Timestamp).toDate(),
        id = snapshot.id;
}
