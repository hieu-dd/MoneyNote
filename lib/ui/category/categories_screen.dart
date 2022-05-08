import 'package:flutter/material.dart';
import 'package:money_note/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  Function(Category) selectCategory;

  CategoriesScreen({required this.selectCategory});

  void _onSelect(BuildContext context, Category category) {
    selectCategory(category);
    _onBack(context);
  }

  _onBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.primaryColor,
          ),
          onPressed: () {
            _onBack(context);
          },
        ),
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Type a category\'s name',
          ),
        ),
      ),
      body: Column(children: [],),
    );
  }
}
