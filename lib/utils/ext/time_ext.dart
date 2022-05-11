extension TimeExt on DateTime {
  bool isSameDay(DateTime time) {
    return day == time.day && month == time.month && year == time.year;
  }

  bool isSameMonth(DateTime time) {
    return month == time.month && year == time.year;
  }
}
