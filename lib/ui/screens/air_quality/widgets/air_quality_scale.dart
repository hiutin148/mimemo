import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/enums/aqi.dart';

class AirQualityScale extends StatelessWidget {
  const AirQualityScale({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Air quality scale',
          style: context.textTheme.titleMedium?.w700,
        ),
        ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shrinkWrap: true,
          itemCount: Aqi.values.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final aqi = Aqi.values[index];
            return Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      spacing: 4,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 2,
                          width: 24,
                          color: aqi.color,
                        ),
                        Text(
                          aqi.name.capitalize,
                          style: context.textTheme.bodyMedium?.w500,
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (index < Aqi.values.length - 1)
                      Text(
                        '${aqi.min.toStringAsFixed(0)} - ${aqi.max.toStringAsFixed(0)}',
                        style: context.textTheme.bodyMedium?.w500,
                      ),
                    if (index == Aqi.values.length - 1)
                      Text(
                        '${aqi.min.toStringAsFixed(0)}+',
                        style: context.textTheme.bodyMedium?.w500,
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Text(
                    aqi.description ?? '',
                    style: context.textTheme.labelMedium,
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Gap(20),
        ),
      ],
    );
  }
}
