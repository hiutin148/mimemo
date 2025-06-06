import 'package:intl/intl.dart';

extension DatetimeExtension on DateTime {
  String toFormatedString(String format) {
    return DateFormat(format).format(this);
  }
}
