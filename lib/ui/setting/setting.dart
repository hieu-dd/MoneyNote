import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Switch(
              value: themeData.isDarkMode,
              onChanged: (value) {
                context.read<ThemeProvider>().setDarkMode();
              },
            )
          ],
        ),
      ),
    );
  }
}
