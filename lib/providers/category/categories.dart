import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';
import 'package:money_note/providers/category/const.dart' as Const;

class CategoriesProvider with ChangeNotifier {
  final List<Category> _categories = Const.categories;

  Future<List<Category>> getCategories(String text) async {
    return _categories
        .where(
          (element) => element.name.toLowerCase().contains(text.toLowerCase()),
        )
        .toList();
  }

  Category findById(String id) {
    return _categories.firstWhere((element) => element.id == id);
  }

// syncCategories() async {
//   if (_categories.isEmpty) {
//     _categories = Const.categories;
//     notifyListeners();
//   }
// }
}
