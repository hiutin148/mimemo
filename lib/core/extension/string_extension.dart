import 'dart:ui';

extension StringExtension on String {
  Color get hexToColor {
    String hex = this;
    hex = hex.toUpperCase().replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse(hex, radix: 16));
  }
}
