import 'package:money_note/models/category/category.dart';
import 'package:flutter/material.dart';

List<Category> categories = [
  Category(
      id: "require_1",
      name: "Food & Beverage",
      icon: Icons.emoji_food_beverage,
      color: Colors.green.shade900),
  Category(
    id: "require_2",
    name: "Transportation",
    icon: Icons.emoji_transportation_outlined,
    color: Colors.yellow.shade900,
  ),
  Category(
    id: "up_1",
    name: "Education",
    level: CategoryLevel.up,
    icon: Icons.cast_for_education_outlined,
    color: Colors.blue.shade900,
  ),
  Category(
    id: "relax_1",
    name: "Sports",
    level: CategoryLevel.relax,
    icon: Icons.sports_soccer_outlined,
    color: Colors.red.shade900,
  ),
];
