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

  DateTime? get toDate {
    try {
      return DateTime.tryParse(this)?.toLocal();
    } on Exception {
      return null;
    }
  }

  String? reformatDateString({required String newFormat, String? oldFormat}) {
    final date = toDate;
    if (date != null) {
      final formattedDate = DateFormat(newFormat).format(date);
      return formattedDate;
    }
    return null;
  }
}
