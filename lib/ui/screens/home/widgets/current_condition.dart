import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/extension/context_extension.dart';
import 'package:mimemo/core/extension/text_style_extension.dart';
import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
import 'package:mimemo/ui/screens/home/home_cubit.dart';
import 'package:mimemo/ui/screens/home/widgets/rain_condition_chart.dart';
import 'package:mimemo/ui/widgets/app_button.dart';
import 'package:mimemo/ui/widgets/app_icon.dart';

class CurrentCondition extends StatefulWidget {
  const CurrentCondition({super.key});

  @override
  State<CurrentCondition> createState() => _CurrentConditionState();
}

class _CurrentConditionState extends State<CurrentCondition> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 360,
        child: Stack(
          children: [
            PageView(children: [RainConditionChart(), RainConditionChart()]),
            BlocSelector<HomeCubit, HomeState, CurrentConditions?>(
              builder: (context, currentConditions) {
                final currentTemperature = currentConditions?.temperature?.metric?.value;
                final unit = currentConditions?.temperature?.metric?.unit ?? '';
                final temText = currentTemperature != null ? '$currentTemperature °$unit' : '';
                final realFeel = currentConditions?.realFeelTemperature?.metric?.value ?? '';
                final icon = currentConditions?.weatherIcon ?? 0;
                return Center(
                  child: SizedBox(
                    width: 264,
                    height: 264,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppIcon(icon: Utils.getIconAsset(icon), size: 56),
                          Text(temText, style: context.textTheme.headlineLarge?.w700.white),
                          Text('RealFeel $realFeel°', style: context.textTheme.bodyMedium?.white),
                          Gap(16),
                          AppButton(
                            width: 100,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            onPressed: () {},
                            child: Row(
                              spacing: 2,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('2 hours'),
                                Icon(Icons.keyboard_arrow_right_outlined),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              selector: (state) => state.currentConditions,
            ),
          ],
        ),
      ),
    );
  }
}
