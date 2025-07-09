import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/core/const/app_colors.dart';
import 'package:mimemo/core/extension/context_extension.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/models/enums/map_type_group.dart';
import 'package:mimemo/ui/screens/radar/radar_cubit.dart';
import 'package:mimemo/ui/widgets/app_inkwell.dart';

class MapTypeList extends StatelessWidget {
  const MapTypeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<RadarCubit, RadarState, AppMapType>(
      builder: (context, currentMapType) {
        return DefaultTabController(
          length: 2,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                        TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.center,
                          labelStyle: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.black,
                          ),
                          unselectedLabelStyle: context.textTheme.bodyMedium?.copyWith(
                            color: Colors.black26,
                          ),
                          labelColor: Colors.black,
                          indicatorColor: AppColors.primary,
                          dividerColor: AppColors.blackBorderColor,
                          dividerHeight: 0.5,
                          tabs: const [
                            Tab(text: 'Radar and map'),
                            Tab(text: 'Settings'),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(12),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final group = AppMapType.values
                              .where(
                                (element) =>
                                    element.group == MapTypeGroup.values[index],
                              )
                              .toList();
                          final groupTitle = MapTypeGroup.values[index].title;
                          return Column(
                            spacing: 12,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (groupTitle.isNotEmpty)
                                Text(
                                  groupTitle,
                                  style: context.textTheme.titleMedium
                                      ?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return AppInkWell(
                                    onTap: () {
                                      context.read<RadarCubit>().changeMapType(
                                        group[index],
                                      );
                                      context.pop();
                                    },
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.05,
                                      ),
                                    ),
                                    borderRadius: 8,
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      spacing: 8,
                                      children: [
                                        Text(
                                          group[index].title,
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: Colors.black,
                                              ),
                                        ),
                                        if (currentMapType == group[index])
                                          const Icon(
                                            Icons.check,
                                            size: 20,
                                            color: Colors.black,
                                          ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Gap(12),
                                itemCount: group.length,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(16),
                        itemCount: MapTypeGroup.values.length,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      selector: (state) => state.currentMapType,
    );
  }
}
