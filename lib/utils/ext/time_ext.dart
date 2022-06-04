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

  Map<String, DateTime> calTimeRange(
    int unit,
    DateTimeType type,
  ) {
    Map<String, DateTime> range = {};
    switch (type) {
      case DateTimeType.day:
        final startToday = DateTime(year, month, day);
        final endToday = DateTime(year, month, day, 23, 59, 59);
        range = {
          "start": startToday.subtract(Duration(days: unit)),
          "end": endToday.subtract(Duration(days: unit)),
        };
        break;
      case DateTimeType.week:
        final startWeek = DateTime(year, month, day - weekday + 1);
        final endWeek = DateTime(year, month, day - weekday + 7, 23, 59, 59);
        range = {
          "start": startWeek.subtract(Duration(days: unit * 7)),
          "end": endWeek.subtract(Duration(days: unit * 7)),
        };
        break;
      case DateTimeType.month:
        final m = month - (unit % 12);
        final y = year - (unit - (unit % 12)) ~/ 12;
        range = {
          "start": DateTime(y, m),
          "end": DateTime(y, m + 1, 0, 23, 59, 59)
        };
        break;
      case DateTimeType.year:
        range = {
          "start": DateTime(year - unit),
          "end": DateTime(year - unit, 12, 31, 23, 59, 59)
        };
        break;
    }
    return range;
  }
}

enum DateTimeType {
  day,
  week,
  month,
  year,
}
