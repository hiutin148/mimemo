import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/models/entities/current_air_quality/current_air_quality.dart';
import 'package:mimemo/models/entities/current_conditions/current_conditions.dart';
import 'package:mimemo/models/entities/hourly_forecast/hourly_forecast.dart';
import 'package:mimemo/models/entities/one_minute_cast/one_minute_cast.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ForecastRepository forecastRepository;
  final CurrentConditionRepository currentConditionRepository;
  final MainCubit mainCubit;

  HomeCubit({
    required this.forecastRepository,
    required this.mainCubit,
    required this.currentConditionRepository,
  }) : super(HomeState());

  Future<void> init() async {
    try {
      getOneMinuteCast();
      getCurrentConditions();
      getAirQuality();
      getNext12HoursForecast();
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> getOneMinuteCast() async {
    try {
      emit(state.copyWith(oneMinuteCastStatus: LoadStatus.loading));
      final (lat, long) = await mainCubit.getCurrentCoordinates();
      final oneMinuteCast = await forecastRepository.get1MinuteCast(lat, long);
      emit(state.copyWith(oneMinuteCastStatus: LoadStatus.success, oneMinuteCast: oneMinuteCast));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(oneMinuteCastStatus: LoadStatus.failure));
    }
  }

  Future<void> getCurrentConditions() async {
    try {
      emit(state.copyWith(currentConditionsStatus: LoadStatus.loading));
      final currentConditions = await currentConditionRepository.getCurrentConditions(
        mainCubit.state.positionInfo?.key ?? '',
      );
      emit(
        state.copyWith(
          currentConditionsStatus: LoadStatus.success,
          currentConditions: currentConditions,
        ),
      );
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(currentConditionsStatus: LoadStatus.failure));
    }
  }

  Future<void> getAirQuality() async {
    try {
      emit(state.copyWith(airQualityStatus: LoadStatus.loading));
      final airQuality = await currentConditionRepository.getCurrentAirQuality(
        mainCubit.state.positionInfo?.key ?? '',
      );
      emit(state.copyWith(airQualityStatus: LoadStatus.success, airQuality: airQuality));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(airQualityStatus: LoadStatus.failure));
    }
  }

  Future<void> getNext12HoursForecast() async {
    try {
      emit(state.copyWith(next12HoursForecastStatus: LoadStatus.loading));
      final next12HoursForecast = await forecastRepository.getNext12HoursForecast(
        mainCubit.state.positionInfo?.key ?? '',
      );
      emit(
        state.copyWith(
          next12HoursForecastStatus: LoadStatus.success,
          next12HoursForecast: next12HoursForecast,
        ),
      );
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(next12HoursForecastStatus: LoadStatus.failure));
    }
  }
}
