import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/core/base/bases.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class SplashCubit extends BaseCubit<bool?> {
  SplashCubit({required this.appSettingRepository, required this.mainCubit}) : super(null);
  final AppSettingRepository appSettingRepository;
  final MainCubit mainCubit;

  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 2));
    final isFirstTime = await appSettingRepository.isFirstTimeOpenApp();
    if (!isFirstTime) {
      await mainCubit.init();
    }
    emit(isFirstTime);
  }
}
