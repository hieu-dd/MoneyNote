import 'package:money_note/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'di/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: const [
      Locale('en'),
      Locale('vi'),
    ],
    path: 'assets/languages',
  ));
}
