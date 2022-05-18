import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/transactions/transaction_item.dart';
import 'package:provider/provider.dart';
import 'package:money_note/models/transaction/transaction.dart';
import 'package:intl/intl.dart';
import 'package:money_note/utils/ext/list_ext.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../providers/category/categories.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final transactionsProvider = context.watch<TransactionsProvider>();
    final categoriesProvider = context.watch<CategoriesProvider>();
    final items = convertTransactionsToItems(transactionsProvider.transactions);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.account_balance_wallet_outlined,
          color: theme.primaryColor,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Money",
              style: theme.textTheme.caption,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              transactionsProvider.spentAmount.formatMoney(),
              style: theme.textTheme.subtitle2,
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.edit_calendar_outlined,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final item = items[index];
                  if (item.type == Type.header) {
                    final time = item.time;
                    final spent = transactionsProvider.spentDay(time);
                    return Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          child: FittedBox(
                            child: Text(
                              time.day.toString(),
                              style: theme.textTheme.headline2!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        title: Text(DateFormat('EEEE').format(time)),
                        subtitle: Text(DateFormat('MMMM-yyyy').format(time)),
                        trailing: Text(
                          spent.formatMoney(),
                          style: theme.textTheme.headlineSmall!
                              .copyWith(color: Colors.pink),
                        ),
                      ),
                    );
                  } else {
                    final transaction = item.transaction!;
                    final category =
                        categoriesProvider.findById(transaction.categoryId);
                    return Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: category.color,
                          child: Icon(
                            category.icon,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(category.name.tr()),
                        subtitle: Text(transaction.note),
                        trailing: Text(
                          transaction.amount.formatMoney(),
                        ),
                      ),
                    );
                  }
                },
                itemCount: items.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<TransactionItem> convertTransactionsToItems(
  List<Transaction> transactions,
) {
  final days = transactions
      .map((e) => TransactionItem(
            time: DateTime(
              e.time.year,
              e.time.month,
              e.time.day,
              23,
              59,
            ),
            type: Type.header,
          ))
      .toList()
      .unique((x) => x.id);
  final items = transactions.map((e) => TransactionItem(
        time: e.time,
        transaction: e,
        type: Type.transaction,
      ));
  return [...items, ...days]..sort((a, b) {
      if (a.time.isAfter(b.time)) {
        return -1;
      } else if (a.time.isBefore(b.time)) {
        return 1;
      } else if (a.type == Type.header) {
        return -1;
      } else {
        return 1;
      }
    });
}
