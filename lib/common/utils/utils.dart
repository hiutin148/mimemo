import 'package:mimemo/generated/assets.dart';

abstract final class Utils {
  static String getIconAsset(int iconId) {
    return switch (iconId) {
      1 => Assets.iconsSun,
      2 || 3 || 4 || 5 => Assets.iconsSunSlowWind,
      _ => Assets.iconsSun,
    };
  }
}
