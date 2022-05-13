import 'package:flutter/cupertino.dart';

class Category {
  String id;
  String name;
  IconData? icon;
  CategoryLevel level;
  Color? color;
  List<Category> subCategories = [];

  Category({
    required this.id,
    required this.name,
    this.level = CategoryLevel.require,
    this.icon,
    this.color,
  });
}

enum CategoryLevel {
  require,
  up,
  relax,
}
