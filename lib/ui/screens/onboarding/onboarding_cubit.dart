import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class OnboardingCubit extends BaseCubit<void> {
  OnboardingCubit({
    required AppSettingRepository appSettingRepository,
    required MainCubit mainCubit,
  }) : _appSettingRepository = appSettingRepository,
       _mainCubit = mainCubit,
       super(null);
  final AppSettingRepository _appSettingRepository;
  final MainCubit _mainCubit;

  void setIsFirstOpen() {
    _appSettingRepository.setIsFirstTimeOpenApp(isFirst: false);
  }

  Future<void> initNotification() async {
    await _mainCubit.initFcm();
  }
}
