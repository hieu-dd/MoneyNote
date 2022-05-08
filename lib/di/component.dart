import 'package:money_note/data/sharedpref/shared_preferences_helper.dart';
import 'package:money_note/providers/category/categories.dart';
import 'package:money_note/providers/theme/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import 'module.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingletonAsync(() async => SharedPreferences.getInstance());
  getIt.registerSingleton(SharedPreferenceHelper(
    await getIt.getAsync<SharedPreferences>(),
  ));
  getIt.registerSingleton(ThemeProvider(getIt.get<SharedPreferenceHelper>()));
  getIt.registerSingleton(TransactionsProvider());
  getIt.registerSingleton(CategoriesProvider());
  getIt.registerSingleton<Dio>(Module.provideDio(
    getIt<SharedPreferenceHelper>(),
  ));
}
