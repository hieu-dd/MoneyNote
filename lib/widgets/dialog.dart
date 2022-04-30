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
                child: Text("Cancel".toUpperCase()),
              ),
              if (fct != null)
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    fct();
                  },
                  child: Text("OK"),
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
                child: Text("Cancel".toUpperCase()),
              ),
            ],
          );
        });
  }
}
