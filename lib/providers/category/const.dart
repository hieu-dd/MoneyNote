import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:money_note/models/category/category.dart';

List<Category> categories = [
  Category(
      id: "require_1",
      name: 'categories_detail.food'.tr(),
      icon: Icons.emoji_food_beverage,
      color: Colors.green.shade300),
  Category(
    id: "require_2",
    name: 'categories_detail.transportation'.tr(),
    icon: Icons.emoji_transportation_outlined,
    color: Colors.yellow.shade300,
  ),
  Category(
      id: "require_3",
      name: 'categories_detail.rentals'.tr(),
      icon: Icons.house_outlined,
      color: Colors.blueGrey.shade300),
  Category(
      id: "require_4",
      name: 'categories_detail.water'.tr(),
      icon: Icons.water_outlined,
      color: Colors.lightBlue),
  Category(
      id: "require_5",
      name: 'categories_detail.phone'.tr(),
      icon: Icons.phone_android_outlined,
      color: Colors.brown.shade700),
  Category(
      id: "require_6",
      name: 'categories_detail.electrical'.tr(),
      icon: Icons.electrical_services_outlined,
      color: Colors.pink.shade300),
  Category(
      id: "require_7",
      name: 'categories_detail.gas'.tr(),
      icon: Icons.local_gas_station,
      color: Colors.red.shade300),
  Category(
      id: "require_8",
      name: 'categories_detail.television'.tr(),
      icon: Icons.tv_outlined,
      color: Colors.deepOrange.shade300),
  Category(
      id: "require_9",
      name: 'categories_detail.internet'.tr(),
      icon: Icons.wifi_calling_outlined,
      color: Colors.purple.shade300),
  Category(
    id: "up_1",
    name: 'categories_detail.education'.tr(),
    level: CategoryLevel.up,
    icon: Icons.cast_for_education_outlined,
    color: Colors.green.shade900,
  ),
  Category(
    id: "up_2",
    name: 'categories_detail.fix_home'.tr(),
    level: CategoryLevel.up,
    icon: Icons.home_repair_service_outlined,
    color: Colors.blue.shade900,
  ),
  Category(
    id: "up_4",
    name: 'categories_detail.fix_vehicle'.tr(),
    level: CategoryLevel.up,
    icon: Icons.motorcycle_outlined,
    color: Colors.red.shade900,
  ),
  Category(
    id: "up_5",
    name: 'categories_detail.healthcare'.tr(),
    level: CategoryLevel.up,
    icon: Icons.local_hospital_outlined,
    color: Colors.yellow.shade900,
  ),
  Category(
    id: "up_6",
    name: 'categories_detail.houseware'.tr(),
    level: CategoryLevel.up,
    icon: Icons.other_houses_outlined,
    color: Colors.pink.shade900,
  ),
  Category(
    id: "up_7",
    name: 'categories_detail.personal'.tr(),
    level: CategoryLevel.up,
    icon: Icons.personal_injury_outlined,
    color: Colors.purple.shade900,
  ),
  Category(
    id: "up_8",
    name: 'categories_detail.service_home'.tr(),
    level: CategoryLevel.up,
    icon: Icons.design_services_outlined,
    color: Colors.orange.shade900,
  ),
  Category(
    id: "relax_1",
    name: 'categories_detail.sports'.tr(),
    level: CategoryLevel.relax,
    icon: Icons.sports_soccer_outlined,
    color: Colors.blue,
  ),
  Category(
    id: "relax_2",
    name: 'categories_detail.beautiful'.tr(),
    level: CategoryLevel.relax,
    icon: Icons.design_services_outlined,
    color: Colors.red,
  ),
  Category(
    id: "relax_3",
    name: 'categories_detail.gift_donation'.tr(),
    level: CategoryLevel.relax,
    icon: Icons.card_giftcard_outlined,
    color: Colors.yellow,
  ),
  Category(
    id: "relax_4",
    name: 'categories_detail.play'.tr(),
    level: CategoryLevel.relax,
    icon: Icons.play_arrow_outlined,
    color: Colors.green,
  ),
];
