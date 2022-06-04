import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import '../utils/ext/time_ext.dart';

PreferredSizeWidget moneyAppbar({
  required BuildContext context,
  required double balance,
  Function? changeRange,
  PreferredSizeWidget? bottom,
}) {
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
      Center(
        child: DropdownButton<DateTimeType>(
          icon: const Icon(Icons.calendar_month),
          elevation: 16,
          style: const TextStyle(color: Colors.black),
          underline: Container(height: 0),
          onChanged: (DateTimeType? newValue) {
            changeRange?.call(newValue);
          },
          items: <DateTimeType>[
            DateTimeType.day,
            DateTimeType.week,
            DateTimeType.month,
            DateTimeType.year,
          ].map<DropdownMenuItem<DateTimeType>>((DateTimeType value) {
            return DropdownMenuItem<DateTimeType>(
              value: value,
              child: Text(
                value == DateTimeType.day
                    ? 'common.day'.tr()
                    : value == DateTimeType.week
                        ? 'common.week'.tr()
                        : value == DateTimeType.month
                            ? 'common.month'.tr()
                            : 'common.year'.tr(),
              ),
            );
          }).toList(),
        ),
      )
    ],
    bottom: bottom,
  );
}