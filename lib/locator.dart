import 'package:get_it/get_it.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';
import 'package:mimemo/repositories/position_repository.dart';
import 'package:mimemo/services/api/api_client.dart';
import 'package:mimemo/services/api/dio_client.dart';
import 'package:mimemo/services/geolocation_service.dart';
import 'package:mimemo/services/shared_preference_service.dart';

final locator = GetIt.instance;

void initLocator() {
  locator.registerLazySingleton<GeoLocationService>(() => GeoLocationService());
  locator.registerLazySingleton<DioClient>(() => DioClient());
  locator.registerLazySingleton<ApiClient>(() => ApiClient(locator<DioClient>().dio));
  locator.registerLazySingleton<SharedPreferencesService>(() => SharedPreferencesService()..init());
  locator.registerLazySingleton<PositionRepository>(
    () => PositionRepositoryImpl(apiClient: locator<ApiClient>()),
  );
  locator.registerLazySingleton<AppSettingRepository>(
    () => AppSettingRepositoryImpl(sharedPreferencesService: locator<SharedPreferencesService>()),
  );
}
