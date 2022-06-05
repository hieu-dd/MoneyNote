import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GlobalDialog {
  static void showAlertDialog(
      String title, String subtitle, Function? fct, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('common.cancel'.tr().toUpperCase()),
              ),
              if (fct != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    fct();
                  },
                  child: Text('common.ok'.tr().toUpperCase()),
                ),
            ],
          );
        });
  }

  static void showAlertError(String subtitle, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('common.cancel'.tr().toUpperCase()),
              ),
            ],
          );
        });
  }
}
