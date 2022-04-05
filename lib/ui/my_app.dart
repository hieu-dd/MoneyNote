import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import '../utils/routes/routes.dart';
import 'home/home.dart';

final _getIt = GetIt.instance;

class MyApp extends StatelessWidget {
  final _themeProvider = _getIt.get<ThemeProvider>();

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
            theme: themeProvider.getThemeData,
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
