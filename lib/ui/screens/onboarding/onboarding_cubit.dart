import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class OnboardingCubit extends BaseCubit<void> {

  OnboardingCubit({required this.appSettingRepository}) : super(null);
  final AppSettingRepository appSettingRepository;

  void setIsFirstOpen() {
    appSettingRepository.setIsFirstTimeOpenApp(isFirst: false);
  }
}
