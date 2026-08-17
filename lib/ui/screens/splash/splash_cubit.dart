import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class SplashCubit extends BaseCubit<bool?> {
  SplashCubit({required this._appSettingRepository, required this._mainCubit})
    : super(null);
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
