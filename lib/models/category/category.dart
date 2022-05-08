import 'package:flutter/cupertino.dart';

class Category {
  String id;
  String name;
  IconData? icon;
  CategoryLevel level;
  List<Category> subCategories = [];

  Category({
    required this.id,
    required this.name,
    this.level = CategoryLevel.require,
    this.icon,
  });
}

enum CategoryLevel {
  require,
  up,
  relax,
}
