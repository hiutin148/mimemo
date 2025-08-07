import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class SplashCubit extends BaseCubit<bool?> {
  SplashCubit({required AppSettingRepository appSettingRepository, required MainCubit mainCubit})
    : _mainCubit = mainCubit,
      _appSettingRepository = appSettingRepository,
      super(null);
  final AppSettingRepository _appSettingRepository;
  final MainCubit _mainCubit;

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final isFirstTime = await _appSettingRepository.isFirstTimeOpenApp();
    if (!isFirstTime) {
      await _mainCubit.init();
      await _mainCubit.initFcm();
    }
    emit(isFirstTime);
  }
}
