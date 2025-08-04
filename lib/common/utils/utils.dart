import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/generated/assets.dart';
import 'package:mimemo/models/entities/gradient_info/gradient_info.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';

export 'app_bloc_observer.dart';
export 'logger.dart';
export 'overlay_loading.dart';

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

  static GradientInfo getProgressiveDbzGradient(double progress, List<MinuteColor> colors) {
    // 1. Xử lý các trường hợp đặc biệt
    if (colors.isEmpty || progress <= 0) {
      return const GradientInfo([Colors.transparent, Colors.transparent], [0.0, 1.0]);
    }
    final clampedProgress = progress.clamp(0.0, 1.0);

    // 2. Xác định phạm vi dBZ
    final minDbz = colors.first.startDbz ?? 0.0;
    // Sử dụng EndDbz của màu cuối cùng để có maxDbz chính xác nhất
    final maxDbz = colors.last.endDbz ?? 95.0; // Dự phòng là 95
    final dbzRange = maxDbz - minDbz;

    if (dbzRange <= 0) {
      final color = colors.first.hex?.hexToColor ?? Colors.white;
      return GradientInfo([color, color], [0.0, 1.0]);
    }

    // 3. Tính toán giá trị dBZ tối đa cho cột này
    final maxDbzForProgress = minDbz + clampedProgress * dbzRange;

    // Nếu dBZ quá nhỏ, gần như bằng 0, trả về màu trong suốt
    if (maxDbzForProgress <= minDbz) {
      return const GradientInfo([Colors.transparent, Colors.transparent], [0.0, 1.0]);
    }

    final gradientColors = <Color>[];
    final gradientRawStops = <double>[]; // Lưu các điểm dừng dBZ gốc

    // 4. Thu thập các màu và điểm dừng dBZ liên quan
    for (final colorInfo in colors) {
      final startDbz = colorInfo.startDbz ?? 0.0;
      final color = colorInfo.hex?.hexToColor ?? Colors.white;

      // Chỉ thêm các điểm dừng nằm trong phạm vi dBZ của cột hiện tại
      if (startDbz < maxDbzForProgress) {
        // Tránh thêm các điểm dừng trùng lặp
        if (gradientRawStops.isNotEmpty && gradientRawStops.last == startDbz) {
          gradientColors[gradientColors.length - 1] = color;
        } else {
          gradientColors.add(color);
          gradientRawStops.add(startDbz);
        }
      } else {
        // Khi đã vượt qua, lấy màu của vùng chứa maxDbzForProgress
        final lastRelevantColor = colors.lastWhereOrNull(
                (c) => (c.startDbz ?? 0.0) <= maxDbzForProgress
        )?.hex?.hexToColor ?? gradientColors.last;

        gradientColors.add(lastRelevantColor);
        gradientRawStops.add(maxDbzForProgress);
        break;
      }
    }

    // Nếu vòng lặp kết thúc mà chưa thêm điểm dừng cuối cùng
    if (gradientRawStops.last < maxDbzForProgress) {
      final lastRelevantColor = colors.last.hex?.hexToColor ?? Colors.white;
      gradientColors.add(lastRelevantColor);
      gradientRawStops.add(maxDbzForProgress);
    }

    // 5. *** BƯỚC QUAN TRỌNG NHẤT: CHUẨN HÓA LẠI CÁC ĐIỂM DỪNG ***
    // Chia mỗi điểm dừng dBZ cho maxDbzForProgress để chúng giãn ra lấp đầy thang [0, 1]
    final normalizedStops = gradientRawStops
        .map((stopDbz) => (stopDbz - minDbz) / (maxDbzForProgress - minDbz))
        .toList();

    // 6. Đảm bảo gradient hợp lệ
    if (gradientColors.length < 2) {
      final singleColor = gradientColors.firstOrNull ?? Colors.transparent;
      return GradientInfo([singleColor, singleColor], [0.0, 1.0]);
    }

    return GradientInfo(gradientColors, normalizedStops);
  }
}
