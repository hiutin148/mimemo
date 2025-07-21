import 'dart:ui';
import 'package:intl/intl.dart';

extension StringExtension on String {
  Color get hexToColor {
    var hex = this;
    hex = hex.toUpperCase().replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }

  DateTime? get toDefaultDate {
    try {
      return DateTime.tryParse(this)?.toLocal();
    } on Exception {
      return null;
    }
  }

  DateTime? toFormatedDate(String format) {
    try {
      return DateFormat(format).parse(this);
    } on Exception {
      return null;
    }
  }

  String? reformatDateString({required String newFormat, String? oldFormat}) {
    final date = oldFormat != null ? toFormatedDate(oldFormat) : toDefaultDate;
    if (date != null) {
      final formattedDate = DateFormat(newFormat).format(date);
      return formattedDate;
    }
    return null;
  }

  bool get isRoundOrHalfHour {
    final regex = RegExp(r'^(?:[01]?[0-9]|2[0-3]):(?:00|30)$');
    return regex.hasMatch(this);
  }
}
