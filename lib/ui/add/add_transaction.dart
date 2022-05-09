import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/models/transaction/transaction.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/category/categories_screen.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../../utils/number_formater.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:money_note/utils/ext/StringExt.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = "/add_transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final _addFormKey = GlobalKey<FormState>();
  final TextEditingController _amountController =
      TextEditingController(text: "0");
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  DateTime? _selectedTime;
  Category? _category;

  void _onSelectCategory(Category category) {
    setState(() {
      _category = category;
      _categoryController.text = category.name;
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
      final _transaction = Transaction(
        amount: double.tryParse(_amountController.text) ?? 0.0,
        category: _category!,
        note: _noteController.text,
        time: _selectedTime!,
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
        title: Text("Add transaction"),
        actions: [
          InkWell(
            onTap: () => {
              _onSave(context),
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Center(
                  child: Text(
                "Save",
                style: theme.textTheme.headline6?.copyWith(color: Colors.white),
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
                      if (double.tryParse(value.orEmpty()) != null) {
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
                    validator: (value) =>
                        value.isNullOrEmpty() ? 'Not empty' : null,
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
                    style: textStyle30,
                    decoration: InputDecoration(
                        hintText: "Select Category",
                        prefixIcon: Icon(Icons.category),
                        disabledBorder: defaultBorder),
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.isNullOrEmpty() ? 'Not empty' : null,
                    controller: _noteController,
                    style: textStyle30,
                    decoration: InputDecoration(
                      hintText: "Write node",
                      prefixIcon: Icon(Icons.note),
                    ),
                  ),
                  TextFormField(
                    validator: (value) =>
                        value.isNullOrEmpty() ? 'Not empty' : null,
                    controller: _timeController,
                    readOnly: true,
                    style: textStyle30,
                    onTap: _selectDateTime,
                    decoration: InputDecoration(
                      hintText: "Today",
                      prefixIcon: Icon(Icons.calendar_today),
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
