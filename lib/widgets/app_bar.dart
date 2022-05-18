import 'package:flutter/material.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:easy_localization/easy_localization.dart';

PreferredSizeWidget moneyAppbar(BuildContext context, double balance) {
  final theme = Theme.of(context);

  return AppBar(
    backgroundColor: Colors.white,
    leading: Icon(
      Icons.account_balance_wallet_outlined,
      color: theme.primaryColor,
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "common.money".tr(),
          style: theme.textTheme.caption,
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          balance.formatMoney(),
          style: theme.textTheme.subtitle2,
        ),
      ],
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit_calendar_outlined,
            color: Colors.black,
          ))
    ],
  );
}
