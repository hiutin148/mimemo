import 'package:mimemo/services/shared_preference_service.dart';

abstract class AppSettingRepository {
  Future<bool> isFirstTimeOpenApp();

  Future<void> setIsFirstTimeOpenApp({required bool isFirst});
}

class AppSettingRepositoryImpl extends AppSettingRepository {
  AppSettingRepositoryImpl({required this.sharedPreferencesService});

  final SharedPreferencesService sharedPreferencesService;

  final isFirstTimeOpenAppKey = 'isFirstTimeOpenApp';

  @override
  Future<bool> isFirstTimeOpenApp() {
    return sharedPreferencesService.getBool(isFirstTimeOpenAppKey, true);
  }

  @override
  Future<void> setIsFirstTimeOpenApp({required bool isFirst}) {
    return sharedPreferencesService.setBool(isFirstTimeOpenAppKey, isFirst);
  }
}
