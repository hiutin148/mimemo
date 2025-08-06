import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/geolocation_service.dart';
import 'package:mimemo/services/supabase_function_service.dart';

part 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit({
    required PositionRepository positionRepository,
    required GeoLocationService geoLocationService,
    required ForecastRepository forecastRepository,
    required SupabaseFunctionService supabaseFunctionService,
  }) : _positionRepository = positionRepository,
       _geoLocationService = geoLocationService,
       _forecastRepository = forecastRepository,
       _supabaseFunctionService = supabaseFunctionService,
       super(const MainState());
  final PositionRepository _positionRepository;
  final GeoLocationService _geoLocationService;
  final ForecastRepository _forecastRepository;
  final SupabaseFunctionService _supabaseFunctionService;

  Future<void> init() async {
    if (state.loadStatus == LoadStatus.loading) return;

    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));

      final (positionInfo, minuteColors) = await (
        _getPositionInfo(),
        _forecastRepository.getMinuteColors(),
      ).wait;
      unawaited(_supabaseFunctionService.saveLocationKey(positionInfo.key));
      unawaited(_positionRepository.setSavedLocationKey(positionInfo.key ?? ''));
      unawaited(_positionRepository.insertRecentPosition(positionInfo));
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          positionInfo: positionInfo,
          minuteColors: minuteColors,
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<(double lat, double lng)> getCurrentCoordinates() async {
    final geoPosition = state.positionInfo?.geoPosition;
    return (geoPosition?.latitude ?? 0.0, geoPosition?.longitude ?? 0.0);
  }

  Future<void> refresh() async {
    await init();
  }

  Future<void> changeLocation(double lat, double long) async {
    try {
      if (await _positionRepository.removeSavedLocationKey()) {
        final result = await _positionRepository.setSavedLatLong(lat, long);
        if (!result) {
          logger.e("Can't save new latitude and longitude.");
        }
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<PositionInfo> _getPositionInfo() async {
    final savedLocationKey = await _positionRepository.getSavedLocationKey();
    if (savedLocationKey?.isNotEmpty ?? false) {
      return _positionRepository.getPositionByLocationKey(savedLocationKey!);
    } else {
      final coordinates = await _positionRepository.getSavedLatLong();
      if (coordinates != null) {
        return _getPositionInfoByLatLong(coordinates.$1, coordinates.$2);
      } else {
        final coordinates = await _geoLocationService.getCurrentPosition();
        return _getPositionInfoByLatLong(coordinates.latitude, coordinates.longitude);
      }
    }
  }

  Future<PositionInfo> _getPositionInfoByLatLong(double lat, double long) async {
    return _positionRepository.getGeoPosition(lat: lat, long: long);
  }
}
