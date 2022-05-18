import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  String title;
  IconData? leadingIcon;
  Color? leadingColor;
  Function? leadingAction;

  MyAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
      leading: leadingIcon != null
          ? IconButton(
              onPressed: () {
                leadingAction?.call();
              },
              icon: Icon(
                leadingIcon,
                color: leadingColor ?? Colors.black,
              ),
            )
          : null,
    );
  }
}
