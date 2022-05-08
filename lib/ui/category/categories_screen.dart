import 'package:flutter/material.dart';
import 'package:money_note/models/category.dart';

class CategoriesScreen extends StatelessWidget {
  Function(Category) selectCategory;

  CategoriesScreen(this.selectCategory);

  void _onSelect(BuildContext context, Category category) {
    selectCategory(category);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Center(
        child: InkWell(
          onTap: () => {_onSelect(context, Category(id: "1", name: "Ahhi"))},
        ),
      ),
    );
  }
}
