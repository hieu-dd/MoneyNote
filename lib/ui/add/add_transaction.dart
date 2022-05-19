import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/models/transaction/transaction.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/category/categories_screen.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../utils/number_formater.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/string_ext.dart';
import 'package:easy_localization/easy_localization.dart';

class AddTransaction extends StatefulWidget {
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _addFormKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _timeController = TextEditingController(
    text: DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
  );

  DateTime _selectedTime = DateTime.now();
  Category? _category;

  void _onSelectCategory(Category category) {
    setState(() {
      _category = category;
      _categoryController.text = category.name.tr();
    });
  }

  void _selectDateTime() {
    final now = DateTime.now();
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: now.subtract(const Duration(days: 365)),
      onConfirm: (date) {
        setState(() {
          _selectedTime = date;
          _timeController.text = DateFormat('yyyy-MM-dd – kk:mm').format(date);
        });
      },
      currentTime: now,
      locale: LocaleType.vi,
    );
  }

  void _onSave(BuildContext context) {
    if (_addFormKey.currentState!.validate()) {
      final _transactionsProviders = context.read<TransactionsProvider>();
      final _transaction = Transaction.autoId(
        amount: -_amountController.text.parseToDouble(),
        categoryId: _category!.id,
        note: _noteController.text,
        time: _selectedTime,
      );
      _transactionsProviders.addTransaction(_transaction);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const textStyle30 = TextStyle(
      fontSize: 30,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: theme.textTheme.titleLarge,
        title: Text('add_transaction.title'.tr()),
        actions: [
          InkWell(
            onTap: () => {
              _onSave(context),
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Center(
                  child: Text(
                'common.save'.tr().capitalize(),
                style: theme.textTheme.titleLarge,
              )),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          children: [
            Form(
              key: _addFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _amountController,
                    validator: (value) {
                      if (value.parseToDouble() > 0.0) {
                        return null;
                      } else {
                        return 'Error format';
                      }
                    },
                    inputFormatters: [NumericTextFormatter()],
                    style: textStyle30.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "0",
                      prefixIcon: Icon(Icons.money),
                      suffixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "đ",
                            style: textStyle30.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: _categoryController,
                    validator: (value) => value.isNullOrEmpty()
                        ? 'add_transaction.not_empty'.tr()
                        : null,
                    readOnly: true,
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesScreen(
                              selectCategory: _onSelectCategory),
                        ),
                      )
                    },
                    style: theme.textTheme.headline5,
                    decoration: InputDecoration(
                        hintText: 'add_transaction.select_category'.tr(),
                        prefixIcon: Icon(_category?.icon ?? Icons.category),
                        disabledBorder: defaultBorder),
                  ),
                  TextFormField(
                    validator: (value) => value.isNullOrEmpty()
                        ? 'add_transaction.not_empty'.tr()
                        : null,
                    controller: _noteController,
                    style: theme.textTheme.headline5,
                    decoration: InputDecoration(
                      hintText: 'add_transaction.write_note'.tr(),
                      prefixIcon: const Icon(Icons.note),
                    ),
                  ),
                  TextFormField(
                    validator: (value) => value.isNullOrEmpty()
                        ? 'add_transaction.not_empty'.tr()
                        : null,
                    controller: _timeController,
                    style: theme.textTheme.headline5,
                    readOnly: true,
                    onTap: _selectDateTime,
                    decoration: InputDecoration(
                      hintText: 'add_transaction.today'.tr(),
                      prefixIcon: const Icon(Icons.calendar_today),
                      disabledBorder: defaultBorder,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

InputBorder defaultBorder = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.grey, width: 1.0),
);
