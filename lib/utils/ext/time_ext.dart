extension TimeExt on DateTime {
  bool isSameDay(DateTime time) {
    return day == time.day && month == time.month && year == time.year;
  }

  bool isSameMonth(DateTime time) {
    return month == time.month && year == time.year;
  }

  DateTime getFirstDayInMonth({int? year, int? month}) {
    return DateTime(year ?? this.year, month ?? this.month);
  }

  DateTime getLastDayInMonth({int? year, int? month}) {
    return DateTime(
        year ?? this.year, (month ?? this.month) + 1, 0, 23, 59, 59);
  }
}
