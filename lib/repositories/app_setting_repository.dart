import 'package:mimemo/services/shared_preference_service.dart';

abstract class AppSettingRepository {
  Future<bool> isFirstTimeOpenApp();

  Future<void> setIsFirstTimeOpenApp({required bool isFirst});

  Future<String?> getSavedLocationKey();
  Future<bool> setSavedLocationKey(String key);
}

class AppSettingRepositoryImpl extends AppSettingRepository {

  AppSettingRepositoryImpl({required this.sharedPreferencesService});
  final SharedPreferencesService sharedPreferencesService;

  final isFirstTimeOpenAppKey = 'isFirstTimeOpenApp';
  final savedLocationKeyKey = 'savedLocationKey';

  @override
  Future<bool> isFirstTimeOpenApp() {
    return sharedPreferencesService.getBool(isFirstTimeOpenAppKey, true);
  }

  @override
  Future<void> setIsFirstTimeOpenApp({required bool isFirst}) {
    return sharedPreferencesService.setBool(isFirstTimeOpenAppKey, isFirst);
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
