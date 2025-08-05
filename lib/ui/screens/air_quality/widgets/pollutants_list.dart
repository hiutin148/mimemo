import 'package:flutter/material.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/current_air_quality/current_air_quality.dart';
import 'package:mimemo/models/enums/aqi.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class PollutantsList extends StatelessWidget {
  const PollutantsList({required this.pollutants, super.key});

  final List<Pollutant> pollutants;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current pollutants',
          style: context.textTheme.titleMedium?.w700,
        ),
        Text(
          'In the last hour',
          style: context.textTheme.bodySmall,
        ),
        ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 12),
          shrinkWrap: true,
          itemCount: pollutants.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final pollutant = pollutants[index];
            final pollutantAqi = AqiExtension.getAQICategory(pollutant.plumeLabsIndex ?? 0);
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pollutant.name ?? ''),
                      Text(pollutant.plumeLabsIndex?.toStringAsFixed(0) ?? ''),
                    ],
                  ),
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
                            color: pollutantAqi.color,
                          ),
                          Text(pollutantAqi.name.capitalize),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        pollutant.concentration?.value?.toStringAsFixed(0) ?? '',
                        style: context.textTheme.labelMedium?.copyWith(color: Colors.white54),
                      ),
                      const Gap(4),
                      Text(
                        pollutant.concentration?.unit ?? '',
                        style: context.textTheme.labelMedium?.copyWith(color: Colors.white54),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Gap(12),
        ),
        Center(
          child: Text(
            'Source: ${pollutants.firstOrNull?.source ?? ''}',
            style: context.textTheme.labelSmall?.copyWith(color: Colors.white54),
          ),
        ),
      ],
    );
  }
}
