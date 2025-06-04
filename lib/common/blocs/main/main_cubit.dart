import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/geolocation_service.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  final PositionRepository positionRepository;
  final GeoLocationService geoLocationService;
  final ForecastRepository forecastRepository;

  MainCubit({
    required this.positionRepository,
    required this.geoLocationService,
    required this.forecastRepository,
  }) : super(MainState());

  Future<void> init() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final position = await geoLocationService.getCurrentPosition();
      final [positionInfo, minuteColors] = await Future.wait([
        positionRepository.getGeoPosition(lat: position.latitude, long: position.longitude),
        forecastRepository.getMinuteColors(),
      ]);

      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          positionInfo: positionInfo as PositionInfo,
          minuteColors: minuteColors as List<MinuteColor>,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<(double lat, double long)> getCurrentLatLong() async {
    if (state.positionInfo?.geoPosition?.latitude == null ||
        state.positionInfo?.geoPosition?.longitude == null) {
      await init();
    }
    final lat = state.positionInfo?.geoPosition?.latitude ?? 0;
    final long = state.positionInfo?.geoPosition?.longitude ?? 0;
    return (lat, long);
  }
}
