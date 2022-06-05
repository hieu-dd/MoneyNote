import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:easy_localization/easy_localization.dart';
import '../utils/ext/time_ext.dart';
import '../utils/ext/string_ext.dart';

PreferredSizeWidget moneyAppbar({
  required BuildContext context,
  required double balance,
  Function? changeRange,
  int? timeLength,
  DateTimeType? timeType,
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
                    ? 'common.day'.tr().capitalize()
                    : value == DateTimeType.week
                        ? 'common.week'.tr().capitalize()
                        : value == DateTimeType.month
                            ? 'common.month'.tr().capitalize()
                            : 'common.year'.tr().capitalize(),
              ),
            );
          }).toList(),
        ),
      )
    ],
    bottom: timeLength != null && timeType != null
        ? TabBar(
            isScrollable: true,
            tabs: List.generate(timeLength, (index) => timeLength - 1 - index)
                .map((e) => Tab(child: tabItem(e, timeType)))
                .toList())
        : null,
  );
}

Widget tabItem(int unit, DateTimeType type) {
  final timeRange = DateTime.now().calTimeRange(unit, type);
  String label;
  switch (type) {
    case DateTimeType.day:
      if (unit == 0) {
        label = 'time.today'.tr();
      } else if (unit == 1) {
        label = 'time.yesterday'.tr();
      } else {
        label = DateFormat('dd MMMM yyyy').format(timeRange["start"]!);
      }
      break;
    case DateTimeType.week:
      if (unit == 0) {
        label = 'time.this_week'.tr();
      } else if (unit == 1) {
        label = 'time.last_week'.tr();
      } else {
        label = "${DateFormat('dd/MM').format(timeRange["start"]!)} - "
            "${DateFormat('dd/MM').format(timeRange["end"]!)}";
      }
      break;
    case DateTimeType.month:
      if (unit == 0) {
        label = 'time.this_month'.tr();
      } else if (unit == 1) {
        label = 'time.last_month'.tr();
      } else {
        label = DateFormat('MMMM yyyy').format(timeRange["start"]!);
      }
      break;

    case DateTimeType.year:
      if (unit == 0) {
        label = 'time.this_year'.tr();
      } else if (unit == 1) {
        label = 'time.last_year'.tr();
      } else {
        label = DateFormat('yyyy').format(timeRange["start"]!);
      }
      break;
  }
  return Text(
    label.toUpperCase(),
    style: TextStyle(color: Colors.black),
  );
}
