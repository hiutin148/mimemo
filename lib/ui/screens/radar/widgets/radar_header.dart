import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/ui/screens/radar/radar_cubit.dart';

class RadarHeader extends StatelessWidget {
  const RadarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadarCubit, RadarState>(
      builder: (context, state) {
        final listGroupColors = state.precipitationColors;
        return Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: listGroupColors.entries
                .map(
                  (colors) => Column(
                spacing: 4,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Row(
                      children: colors.value
                          .map(
                            (color) => Container(
                          width: 16,
                          height: 10,
                          color: color.hex?.hexToColor,
                        ),
                      )
                          .toList(),
                    ),
                  ),
                  Text(
                    colors.key ?? '',
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
                .toList(),
          ),
        );
      },
    );
  }
}
