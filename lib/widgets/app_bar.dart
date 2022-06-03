import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:money_note/utils/ext/double_ext.dart';
import 'package:easy_localization/easy_localization.dart';

PreferredSizeWidget moneyAppbar({
  required BuildContext context,
  required double balance,
  Map<String, DateTime>? timeRange,
  Function? onChangeTime,
}) {
  final theme = Theme.of(context);

  void _onClickTimeChange() {
    final now = DateTime.now();
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: now.subtract(const Duration(days: 365)),
      onConfirm: (date) {
        onChangeTime?.call(date);
      },
      currentTime: now,
      locale: LocaleType.vi,
    );
  }

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
      if (timeRange != null) timeDetail(timeRange),
      IconButton(
        onPressed: _onClickTimeChange,
        icon: const Icon(
          Icons.edit_calendar_outlined,
          color: Colors.black,
        ),
      ),
    ],
  );
}

Widget timeDetail(Map<String, DateTime> time) {
  final timeStart = time["start"]!;
  return Center(
    child: Text(
      DateFormat('MM/yy').format(timeStart),
      style: TextStyle(color: Colors.black),
    ),
  );
}
