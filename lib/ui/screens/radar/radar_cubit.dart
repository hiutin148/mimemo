import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/common/utils/logger.dart';
import 'package:mimemo/core/extension/datetime_extension.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/models/entities/minute_color/minute_color.dart';
import 'package:mimemo/models/enums/app_map_type.dart';
import 'package:mimemo/models/enums/load_status.dart';
import 'package:mimemo/services/api/api_client_endpoints.dart';

part 'radar_state.dart';

class RadarCubit extends Cubit<RadarState> {
  RadarCubit({required this.mainCubit}) : super(const RadarState());

  final MainCubit mainCubit;

  void init() {
    try {
      final groupColors = groupBy<MinuteColor, String?>(
        mainCubit.state.minuteColors,
            (color) => color.type,
      );

      emit(
        state.copyWith(
          loadStatus: LoadStatus.success,
          precipitationColors: groupColors,
          tileUrl: _buildTileUrl(state.currentMapType),
        ),
      );
    } on Exception catch (e) {
      logger.e(e);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void changeMapType(AppMapType mapType) {
    emit(
      state.copyWith(
        currentMapType: mapType,
        tileUrl: _buildTileUrl(mapType),
      ),
    );
  }

  String _buildTileUrl(AppMapType mapType) {
    final endpoint = _endpointFor(mapType);
    return endpoint.needsDateTime
        ? endpoint.template.withDateTime(_currentTimestamp())
        : endpoint.template;
  }

  ({String template, bool needsDateTime}) _endpointFor(AppMapType mapType) {
    return switch (mapType) {
      AppMapType.radar ||
      AppMapType.forecastEyePath => (
      template: ApiClientEndpoints.radarEndpoint,
      needsDateTime: true,
      ),
      AppMapType.clouds => (
      template: ApiClientEndpoints.cloudSatelliteEndpoint,
      needsDateTime: true,
      ),
    // giữ đúng behavior cũ: getCloudSatellite(..., '20') -> nối '20' vào display_products=
      AppMapType.colorEnhancedClouds => (
      template: '${ApiClientEndpoints.cloudSatelliteEndpoint}20',
      needsDateTime: true,
      ),
      AppMapType.waterVapor => (
      template: ApiClientEndpoints.waterVaporEndpoint,
      needsDateTime: true,
      ),
      AppMapType.temperature ||
      AppMapType.temperatureForecast => (
      template: ApiClientEndpoints.currentTemperatureEndpoint,
      needsDateTime: true,
      ),
    // các loại time-independent, không cần {dateTime}
      AppMapType.risk => (
      template: ApiClientEndpoints.riskTropicalEndpoint,
      needsDateTime: false,
      ),
      AppMapType.rainfallAmounts => (
      template: ApiClientEndpoints.rainFallAmountsEndpoint,
      needsDateTime: false,
      ),
      AppMapType.forecastedMaximumSustainedWinds => (
      template: ApiClientEndpoints.maximumSustainedWindsEndpoint,
      needsDateTime: false,
      ),
      AppMapType.forecastedMaximumWindGusts => (
      template: ApiClientEndpoints.maximumWindGustsEndpoint,
      needsDateTime: false,
      ),
      AppMapType.stormSurge => (
      template: ApiClientEndpoints.stormSurgeEndpoint,
      needsDateTime: false,
      ),
      AppMapType.watchesAndWarnings => (
      template: ApiClientEndpoints.watchesAndWarningsEndpoint,
      needsDateTime: false,
      ),
    };
  }

  String _currentTimestamp() {
    return DateTime.now().toUtc().toFormatedString(DateFormatPattern.dateTimeFull);
  }
}