import 'package:base_flutter_project/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'di/component.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: const [
      Locale('en'),
      Locale('vi'),
    ],
    path: 'assets/languages',
  ));
}
