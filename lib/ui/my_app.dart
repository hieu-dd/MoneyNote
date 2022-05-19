import 'package:money_note/providers/category/categories.dart';
import 'package:money_note/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:money_note/providers/transaction/transactions.dart';
import 'package:money_note/ui/bottom_bar.dart';
import 'package:money_note/ui/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

final _getIt = GetIt.instance;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeProvider = _getIt.get<ThemeProvider>();
  final _transactionsProvider = _getIt.get<TransactionsProvider>();
  final _categoriesProvider = _getIt.get<CategoriesProvider>();

  void getAppTheme() async {
    await _themeProvider.getDarkMode();
  }

  @override
  void initState() {
    getAppTheme();
    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => _themeProvider,
        ),
        ChangeNotifierProvider<TransactionsProvider>(
          create: (_) => _transactionsProvider,
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (_) => _categoriesProvider,
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              initialData: null,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text(snapshot.error!.toString()),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return BottomBarScreen();
                } else {
                  return LoginScreen();
                }
              },
            ),
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
