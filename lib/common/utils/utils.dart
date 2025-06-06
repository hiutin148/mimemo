import 'package:mimemo/generated/assets.dart';

abstract final class Utils {
  static String getIconAsset(int iconId) {
    return switch (iconId) {
      1 => Assets.iconsSun,
      2 || 3 || 4 || 5 => Assets.iconsSunSlowWind,
      6 => Assets.iconsSunCloud,
      7 || 8 => Assets.iconsCloud,
      11 => Assets.iconsSlowWind,
      12 || 18 => Assets.iconsCloudLittleRain,
      13 || 14 => Assets.iconsSunCloudLittleRain,
      15 || 16 => Assets.iconsCloudAngledRainZap,
      17 => Assets.iconsSunCloudZap,
      // TODO
      _ => Assets.iconsSun,
    };
  }
}
