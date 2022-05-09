import 'package:intl/intl.dart';

extension StringExt on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

  String orEmpty() {
    return this ?? "";
  }

  double parseToDouble() {
    final f = NumberFormat("#,###");
    return double.tryParse(orEmpty().replaceAll(f.symbols.GROUP_SEP, "")) ??
        0.0;
  }
}
