import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_note/models/category.dart';
import 'package:money_note/ui/category/categories_screen.dart';
import 'package:money_note/utils/routes/routes.dart';

import '../../utils/number_formater.dart';

class AddTransaction extends StatefulWidget {
  static const routeName = "/add_transaction";

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final TextEditingController _amountController =
      TextEditingController(text: "0");
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

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
              _amountController.text = "1234"
              // Navigator.of(context).pop()
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
                child: Column(
              children: [
                TextFormField(
                  controller: _amountController,
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
                InkWell(
                  onTap: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoriesScreen(
                          (category) => {
                            _categoryController.text = category.name,
                          },
                        ),
                      ),
                    )
                  },
                  child: TextFormField(
                    controller: _categoryController,
                    enabled: false,
                    style: TextStyle(fontSize: 30),
                    decoration: InputDecoration(
                        hintText: "Select Category",
                        prefixIcon: Icon(Icons.category),
                        disabledBorder: defaultBorder),
                  ),
                ),
                TextFormField(
                  controller: _noteController,
                  style: textStyle30,
                  decoration: InputDecoration(
                    hintText: "Write node",
                    prefixIcon: Icon(Icons.note),
                  ),
                ),
                TextFormField(
                  controller: _timeController,
                  enabled: false,
                  style: textStyle30,
                  decoration: InputDecoration(
                    hintText: "Today",
                    prefixIcon: Icon(Icons.calendar_today),
                    disabledBorder: defaultBorder,
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

InputBorder defaultBorder = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.grey, width: 1.0),
);
