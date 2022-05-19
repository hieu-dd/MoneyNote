import 'package:money_note/providers/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends StatelessWidget {
  void _logout() {
    FirebaseAuth.instance.signOut();
  }

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
            ),
            InkWell(
              onTap: _logout,
              child: Text('account.sign_out'.tr()),
            )
          ],
        ),
      ),
    );
  }
}
