import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/core/exceptions/app_exceptions.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/entities/position_info/position_info.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/notification_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';

part 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit({
    required this._positionRepository,
    required this._forecastRepository,
    required this._notificationRepository,
  }) : super(const MainState());

  final PositionRepository _positionRepository;
  final ForecastRepository _forecastRepository;
  final NotificationRepository _notificationRepository;

  Future<void> init() async {
    if (state.loadStatus == LoadStatus.loading) return;

    emit(
      state.copyWith(
        loadStatus: LoadStatus.loading,
        errorType: MainErrorType.none,
        errorMessage: null,
      ),
    );

    try {
      final (positionInfo, minuteColors) = await (
        _positionRepository.getCurrentPositionInfo(),
        _forecastRepository.getMinuteColors().catchError((e) {
          logger.w('Không tải được forecast, dùng giá trị mặc định: $e');
          return <MinuteColor>[];
        }),
      ).wait;

      _syncBackgroundData(positionInfo);

      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          positionInfo: positionInfo,
          minuteColors: minuteColors,
        ),
      );
    } catch (e, stackTrace) {
      logger.e('Init MainCubit failed', error: e, stackTrace: stackTrace);
      _handleError(e);
    }
  }

  void _handleError(Object error) {
    MainErrorType errorType = MainErrorType.unknownError;
    String errorMessage = 'Đã có lỗi xảy ra. Vui lòng thử lại.';

    if (error is LocationPermissionException) {
      errorType = MainErrorType.locationPermissionDenied;
      errorMessage = 'Ứng dụng cần quyền vị trí để dự báo thời tiết.';
    } else if (error is LocationDisabledException) {
      errorType = MainErrorType.locationServiceDisabled;
      errorMessage = 'Vui lòng bật định vị (GPS) trên thiết bị.';
    } else if (error is NetworkException) {
      errorType = MainErrorType.networkError;
      errorMessage = 'Mất kết nối Internet. Vui lòng kiểm tra lại mạng.';
    }

    if (state.positionInfo != null) {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          errorType: errorType,
          errorMessage: errorMessage,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loadStatus: LoadStatus.failure,
          errorType: errorType,
          errorMessage: errorMessage,
        ),
      );
    }
  }

  void _syncBackgroundData(PositionInfo positionInfo) {
    unawaited(_notificationRepository.syncLocationKey(positionInfo.key));
    if (positionInfo.key != null) {
      unawaited(_positionRepository.setSavedLocationKey(positionInfo.key!));
    }
    unawaited(_positionRepository.insertRecentPosition(positionInfo));
  }

  Future<void> initFcm() async {
    await _notificationRepository.initialize();
    if (state.positionInfo?.key != null) {
      await _notificationRepository.syncLocationKey(state.positionInfo!.key);
    }
  }

  Future<void> changeLocation(double lat, double long) async {
    try {
      final success = await _positionRepository.changeLocation(lat, long);
      if (success) {
        await init();
      } else {
        logger.e("Can't save new latitude and longitude.");
      }
    } catch (e, stackTrace) {
      logger.e('Error changing location', error: e, stackTrace: stackTrace);
    }
  }

  (double lat, double lng) getCurrentCoordinates() {
    final geoPosition = state.positionInfo?.geoPosition;
    return (geoPosition?.latitude ?? 0.0, geoPosition?.longitude ?? 0.0);
  }

  Future<void> refresh() => init();
}
