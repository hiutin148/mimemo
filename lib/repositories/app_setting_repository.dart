import 'package:mimemo/services/shared_preference_service.dart';

abstract class AppSettingRepository {
  Future<bool> isFirstTimeOpenApp();

  Future<void> setIsFirstTimeOpenApp(bool value);
}

class AppSettingRepositoryImpl extends AppSettingRepository {
  final SharedPreferencesService sharedPreferencesService;

  AppSettingRepositoryImpl({required this.sharedPreferencesService});

  final isFirstTimeOpenAppKey = 'isFirstTimeOpenApp';

  @override
  Future<bool> isFirstTimeOpenApp() {
    return sharedPreferencesService.getBool(isFirstTimeOpenAppKey, true);
  }

  @override
  Future<void> setIsFirstTimeOpenApp(bool value) {
    return sharedPreferencesService.setBool(isFirstTimeOpenAppKey, value);
  }
}
