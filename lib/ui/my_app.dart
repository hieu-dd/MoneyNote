import 'package:money_note/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:money_note/ui/bottom_bar.dart';
import 'package:money_note/ui/login/login.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../utils/routes/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

final _getIt = GetIt.instance;

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeProvider = _getIt.get<ThemeProvider>();

  void getAppTheme() async {
    await _themeProvider.getDarkMode();
  }

  @override
  void initState() {
    getAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => _themeProvider,
        )
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: themeProvider.getThemeData,
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
