extension TimeExt on DateTime {
  bool isSameDay(DateTime time) {
    return day == time.day && month == time.month && year == time.year;
  }
}
