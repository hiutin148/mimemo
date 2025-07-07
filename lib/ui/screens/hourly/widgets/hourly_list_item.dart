import 'package:flutter/material.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HourlyListItem extends StatelessWidget {
  const HourlyListItem({required this.hour, super.key, this.onItemTap});

  final HourlyForecast hour;
  final VoidCallback? onItemTap;

  @override
  Widget build(BuildContext context) {
    final displayTime =
        hour.dateTime?.reformatDateString(newFormat: DateFormatPattern.time) ??
        '';
    return AppInkWell(
      onTap: onItemTap,
      padding: const EdgeInsets.all(16),
      borderRadius: 4,
      decoration: const BoxDecoration(
        color: Colors.white12,
      ),
      child: Row(
        spacing: 16,
        children: [
          Text(displayTime, style: context.textTheme.bodySmall),
          AppIcon(icon: Utils.getIconAsset(hour.weatherIcon ?? 0)),
          Text(
            '${hour.temperature?.value?.toStringAsFixed(0) ?? 0}°${hour.temperature?.unit ?? ''}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            'RealFeel ${hour.temperature?.value?.toStringAsFixed(0) ?? 0}°${hour.temperature?.unit ?? ''}',
            style: context.textTheme.bodySmall,
          ),
          const Spacer(),
          Column(
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.water_drop_outlined,
                    color: Colors.white54,
                    size: 16,
                  ),
                  const Gap(2),
                  Text(
                    '${hour.relativeHumidity ?? '--'}%',
                    style: context.textTheme.labelMedium?.copyWith(
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
              if (hour.totalLiquid?.value != 0)
                Text(
                  '${hour.totalLiquid?.value ?? 0}${hour.totalLiquid?.unit ?? ''}',
                  style: context.textTheme.labelMedium?.copyWith(
                    color: Colors.white54,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
