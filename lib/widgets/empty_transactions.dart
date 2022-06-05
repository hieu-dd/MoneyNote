import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../consts/assets.dart';

Widget emptyTransactions(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          width: 100,
          height: 100,
          child: Image(
            image: AssetImage(Assets.emptyBox),
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'empty.no_transactions'.tr(),
          style:
              Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 25),
          textAlign: TextAlign.center,
        )
      ],
    ),
  );
}
