import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/geolocation_service.dart';

part 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {

  MainCubit({
    required PositionRepository positionRepository,
    required GeoLocationService geoLocationService,
    required ForecastRepository forecastRepository,
    required AppSettingRepository appSettingRepository,
  }) : _positionRepository = positionRepository,
       _geoLocationService = geoLocationService,
       _forecastRepository = forecastRepository,
       _appSettingRepository = appSettingRepository,
       super(const MainState());
  final PositionRepository _positionRepository;
  final GeoLocationService _geoLocationService;
  final ForecastRepository _forecastRepository;
  final AppSettingRepository _appSettingRepository;

  Future<void> init() async {
    if (state.loadStatus == LoadStatus.loading) return;

    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));

      final (positionInfo, minuteColors) =
          await (_getPositionInfo(), _forecastRepository.getMinuteColors()).wait;

      unawaited(_appSettingRepository.setSavedLocationKey(positionInfo.key ?? ''));

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
    await _ensureInitialized();

    final geoPosition = state.positionInfo?.geoPosition;
    return (geoPosition?.latitude ?? 0.0, geoPosition?.longitude ?? 0.0);
  }

  Future<void> refresh() async {
    await init();
  }

  Future<void> _ensureInitialized() async {
    if (!_hasValidPosition) {
      await init();
    }
  }

  Future<PositionInfo> _getPositionInfo() async {
    final savedLocationKey = await _appSettingRepository.getSavedLocationKey();

    return savedLocationKey?.isNotEmpty ?? false
        ? _positionRepository.getPositionByLocationKey(savedLocationKey!)
        : _getPositionInfoByLatLong();
  }

  Future<PositionInfo> _getPositionInfoByLatLong() async {
    final position = await _geoLocationService.getCurrentPosition();
    return _positionRepository.getGeoPosition(lat: position.latitude, long: position.longitude);
  }

  bool get _hasValidPosition {
    final geoPosition = state.positionInfo?.geoPosition;
    return geoPosition?.latitude != null && geoPosition?.longitude != null;
  }
}
