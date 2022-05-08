import 'package:money_note/ui/add/add_transaction.dart';
import 'package:money_note/ui/category/categories_screen.dart';
import 'package:money_note/ui/setting/setting.dart';
import 'package:flutter/cupertino.dart';

import '../../ui/splash/splash_screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String setting = '/setting';
  static const String addTransaction = "/add_transaction";
  static const String categories = "/categories";

  static final routes = {
    splash: (BuildContext context) => SplashScreen(),
    setting: (BuildContext context) => SettingScreen(),
    addTransaction: (BuildContext context) => AddTransaction(),
  };
}
