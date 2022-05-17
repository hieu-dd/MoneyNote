import 'package:money_note/ui/my_app.dart';
import 'package:flutter/material.dart';
import 'di/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'models/transaction/transaction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();
  await hiveInit();

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: const [
      Locale('en'),
      Locale('vi'),
    ],
    path: 'assets/languages',
  ));
}

Future<void> hiveInit() async {
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox('transactions');
}
