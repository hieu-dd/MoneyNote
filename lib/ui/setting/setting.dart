import 'package:base_flutter_project/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeData = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('setting.title'.tr()),
      ),
      body: Container(
        width: double.infinity,
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'setting.dark_theme'.tr(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Switch(
                  value: themeData.isDarkMode,
                  onChanged: (value) {
                    context.read<ThemeProvider>().setDarkMode();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
