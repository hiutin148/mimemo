import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/fcm_service.dart';
import 'package:mimemo/services/geolocation_service.dart';
import 'package:mimemo/services/local_notification_service.dart';
import 'package:mimemo/services/supabase_function_service.dart';

part 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit({
    required PositionRepository positionRepository,
    required GeoLocationService geoLocationService,
    required ForecastRepository forecastRepository,
    required SupabaseFunctionService supabaseFunctionService,
    required FcmService fcmService,
    required LocalNotificationService localNotificationService,
  }) : _positionRepository = positionRepository,
       _geoLocationService = geoLocationService,
       _forecastRepository = forecastRepository,
       _supabaseFunctionService = supabaseFunctionService,
       _fcmService = fcmService,
       _localNotificationService = localNotificationService,
       super(const MainState());
  final PositionRepository _positionRepository;
  final GeoLocationService _geoLocationService;
  final ForecastRepository _forecastRepository;
  final SupabaseFunctionService _supabaseFunctionService;
  final FcmService _fcmService;
  final LocalNotificationService _localNotificationService;

  Future<void> init() async {
    if (state.loadStatus == LoadStatus.loading) return;

    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));

      final (positionInfo, minuteColors) = await (
        _getPositionInfo(),
        _forecastRepository.getMinuteColors(),
      ).wait;
      final savedToken = await _fcmService.getSavedToken();
      if (savedToken != null) {
        unawaited(_supabaseFunctionService.saveLocationKey(positionInfo.key, savedToken));
      }
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

  Future<void> initFcm() async {
    if (!_fcmService.isInitialized) {
      await _fcmService.initialize(
        onNotificationTapped: (data) async {},
      );
      await _localNotificationService.initialize();
      final token = await _fcmService.getToken();
      if (token != null) {
        await _supabaseFunctionService.saveFcmToken(token);
        await _supabaseFunctionService.saveLocationKey(state.positionInfo?.key, token);
      }
      _fcmService.onForegroundMessage.listen(
        (message) {
          if (message.notification != null) {
            _localNotificationService.showNotification(
              id: 0,
              title: message.notification!.title ?? '',
              body: message.notification!.body ?? '',
            );
          }
        },
      );
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
