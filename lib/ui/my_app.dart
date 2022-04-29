import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../utils/routes/routes.dart';
import 'bottom_bar.dart';
import 'home/home.dart';
import 'package:easy_localization/easy_localization.dart';

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
            home: BottomBarScreen(),
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
