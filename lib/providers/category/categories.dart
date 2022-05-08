import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/providers/category/const.dart' as Const;

class CategoriesProvider with ChangeNotifier {
  List<Category> _categories = [];

  Future<List<Category>> getCategories() async {
    if (_categories.isEmpty) {
      _categories = Const.categories;
    }
    return _categories;
  }
}
