import 'package:get_it/get_it.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';
import 'package:mimemo/repositories/current_condition_repository.dart';
import 'package:mimemo/repositories/forecast_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/api/api_client.dart';
import 'package:mimemo/services/api/dio_client.dart';
import 'package:mimemo/services/geolocation_service.dart';
import 'package:mimemo/services/shared_preference_service.dart';

final GetIt locator = GetIt.instance;

void initLocator() {
  locator
    ..registerLazySingleton<GeoLocationService>(GeoLocationService.new)
    ..registerLazySingleton<DioClient>(DioClient.new)
    ..registerLazySingleton<ApiClient>(() => ApiClient(locator<DioClient>().dio))
    ..registerLazySingleton<SharedPreferencesService>(() => SharedPreferencesService()..init())
    ..registerLazySingleton<PositionRepository>(
      () => PositionRepositoryImpl(apiClient: locator<ApiClient>()),
    )
    ..registerLazySingleton<AppSettingRepository>(
      () => AppSettingRepositoryImpl(sharedPreferencesService: locator<SharedPreferencesService>()),
    )
    ..registerLazySingleton<ForecastRepository>(
      () => ForecastRepositoryImpl(apiClient: locator<ApiClient>()),
    )
    ..registerLazySingleton<CurrentConditionRepository>(
      () => CurrentConditionRepositoryImpl(apiClient: locator<ApiClient>()),
    );
}
