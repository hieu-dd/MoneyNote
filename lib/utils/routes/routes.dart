import 'package:base_flutter_project/ui/home/home.dart';
import 'package:base_flutter_project/ui/setting/setting.dart';
import 'package:flutter/cupertino.dart';

import '../../ui/splash/splash_screen.dart';

class Routes {
  static const String splash = '/splash';
  static const String setting = '/setting';
  static const String home = '/home';

  static final routes = {
    splash: (BuildContext context) => SplashScreen(),
    home: (BuildContext context) => HomeScreen(),
    setting: (BuildContext context) => SettingScreen(),
  };
}
