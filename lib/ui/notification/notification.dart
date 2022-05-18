import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:money_note/utils/ext/string_ext.dart';

import '../../consts/assets.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'notification.common'.tr().capitalize(),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear_all_outlined,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: emptyNotification(context),
      ),
    );
  }
}

Widget emptyNotification(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 100,
          height: 100,
          child: Image(
            image: AssetImage(Assets.logoNotification),
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "You have no alerts \nat this time",
          style:
              Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
