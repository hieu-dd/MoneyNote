import 'package:intl/intl.dart';

extension DoubleExt on double {
  String formatMoney() {
    final f = NumberFormat("#,###");
    var currency = NumberFormat.simpleCurrency(locale: "vi");
    return "${f.format(this)} ${currency.currencySymbol}";
  }
}
