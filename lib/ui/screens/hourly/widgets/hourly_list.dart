import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/core/const/app_colors.dart';
import 'package:mimemo/core/extension/context_extension.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:mimemo/ui/screens/hourly/widgets/hourly_list_item.dart';

class HourlyList extends StatelessWidget {
  const HourlyList({required this.onItemTap, super.key});

  final VoidCallback onItemTap;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HourlyCubit, HourlyState, List<HourlyDateData>>(
      selector: (state) => state.hourlyDates,
      builder: (context, hourlyDates) {
        final filteredDates = hourlyDates
            .where((date) => date.forecasts?.isNotEmpty ?? false)
            .toList();

        if (filteredDates.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        return DefaultStickyHeaderController(
          child: AnimationLimiter(
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: filteredDates.asMap().entries.map((entry) {
                final groupIndex = entry.key;
                final date = entry.value;
                return SliverStickyHeader.builder(
                  builder: (context, state) =>
                      _buildHeader(context, date, state),
                  sliver: _buildForecastList(date, groupIndex),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(
    BuildContext context,
    HourlyDateData date,
    SliverStickyHeaderState state,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        border: state.isPinned
            ? const Border(
                bottom: BorderSide(
                  color: AppColors.whiteBorderColor,
                  width: 0.5,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (date.weekday?.isNotEmpty ?? false)
            Text(
              date.weekday!,
              style: context.textTheme.titleMedium,
            ),
          if (date.date?.isNotEmpty ?? false)
            Text(
              date.date!,
              style: context.textTheme.labelSmall?.copyWith(
                color: Colors.white54,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildForecastList(HourlyDateData date, int groupIndex) {
    final forecasts = date.forecasts!;

    return SliverPadding(
      padding: const EdgeInsets.all(16),
      sliver: SliverList.separated(
        itemCount: forecasts.length,
        itemBuilder: (context, index) {
          final hour = forecasts[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == date.sunSetIndex && date.sunSet != null)
                _buildSunInfo(context, 'Sun sets: ${date.sunSet!}'),
              if (index == date.sunRiseIndex && date.sunRise != null)
                _buildSunInfo(context, 'Sun rises: ${date.sunRise!}'),
              HourlyListItem(
                hour: hour,
                onItemTap: onItemTap,
              ),
            ],
          );
        },
        separatorBuilder: (context, index) => const Gap(16),
      ),
    );
  }

  Widget _buildSunInfo(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(
            Icons.sunny,
            color: Colors.white,
            size: 16,
          ),
          Text(
            ' $text',
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
