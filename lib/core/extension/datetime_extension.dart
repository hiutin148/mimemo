import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String toFormatedString(String format) {
    return DateFormat(format).format(this);
  }

  String get dayOfWeek {
    return DateFormat('EE').format(this);
  }
}
