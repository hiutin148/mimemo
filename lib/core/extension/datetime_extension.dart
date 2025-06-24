import 'package:intl/intl.dart';
import 'package:mimemo/core/const/consts.dart';

extension DatetimeExtension on DateTime {
  String toFormatedString(String format) {
    return DateFormat(format).format(this);
  }

  String get dayOfWeek {
    return DateFormat(DateFormatPattern.shortDayOfWeek).format(this);
  }
}
