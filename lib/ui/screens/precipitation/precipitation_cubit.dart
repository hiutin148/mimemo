import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:mimemo/common/utils/utils.dart';
import 'package:mimemo/core/base/base_cubit.dart';
import 'package:mimemo/core/extension/extensions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/ui/screens/hourly/hourly_cubit.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

part 'precipitation_state.dart';

class PrecipitationCubit extends BaseCubit<PrecipitationState> {
  PrecipitationCubit({required this.hourlyCubit, this.oneMinuteCast})
    : super(const PrecipitationState());
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController = ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

  final HourlyCubit hourlyCubit;
  final OneMinuteCast? oneMinuteCast;

  Future<void> init() async {
    try {
      itemPositionsListener.itemPositions.addListener(
        itemPositionsListenerListener,
      );

      final selectedMinute = oneMinuteCast?.intervals?.first;
      final selectedHour = hourlyCubit.state.hourlyForecasts.firstWhereOrNull(
        (element) =>
            element.dateTime?.toDefaultDate?.hour ==
            selectedMinute?.startDateTime?.toDefaultDate?.hour,
      );
      emit(
        state.copyWith(
          selectedMinute: selectedMinute,
          selectedHour: selectedHour,
          oneMinuteCast: oneMinuteCast,
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  void itemPositionsListenerListener() {
    final positions = itemPositionsListener.itemPositions.value.sorted(
      (a, b) => a.index > b.index
          ? 1
          : a.index == b.index
          ? 0
          : -1,
    );

    if (positions.isNotEmpty) {
      final firstVisibleItemIndex = positions.first.index;
      if (state.focusedIndex != firstVisibleItemIndex) {
        final selectedMinute = state.oneMinuteCast?.intervals?[firstVisibleItemIndex];
        var selectedHour = state.selectedHour;
        if (selectedHour?.dateTime?.toDefaultDate?.hour !=
            selectedMinute?.startDateTime?.toDefaultDate?.hour) {
          selectedHour = selectedHour = hourlyCubit.state.hourlyForecasts.firstWhereOrNull(
            (element) =>
                element.dateTime?.toDefaultDate?.hour ==
                selectedMinute?.startDateTime?.toDefaultDate?.hour,
          );
        }
        emit(
          state.copyWith(
            focusedIndex: firstVisibleItemIndex,
            selectedMinute: selectedMinute,
            selectedHour: selectedHour,
          ),
        );
      }
    }
  }
}
