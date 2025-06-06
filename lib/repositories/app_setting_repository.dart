import 'package:mimemo/services/shared_preference_service.dart';

abstract class AppSettingRepository {
  Future<bool> isFirstTimeOpenApp();

  Future<void> setIsFirstTimeOpenApp(bool value);

  Future<String?> getSavedLocationKey();
  Future<bool> setSavedLocationKey(String key);
}

class AppSettingRepositoryImpl extends AppSettingRepository {
  final SharedPreferencesService sharedPreferencesService;

  AppSettingRepositoryImpl({required this.sharedPreferencesService});

  final isFirstTimeOpenAppKey = 'isFirstTimeOpenApp';
  final savedLocationKeyKey = 'savedLocationKey';

  @override
  Future<bool> isFirstTimeOpenApp() {
    return sharedPreferencesService.getBool(isFirstTimeOpenAppKey, true);
  }

  @override
  Future<void> setIsFirstTimeOpenApp(bool value) {
    return sharedPreferencesService.setBool(isFirstTimeOpenAppKey, value);
  }

  @override
  Future<String?> getSavedLocationKey() {
    return sharedPreferencesService.getString(savedLocationKeyKey, '');

  }

  @override
  Future<bool> setSavedLocationKey(String key) {
    return sharedPreferencesService.setString(savedLocationKeyKey, key);

  }
}
