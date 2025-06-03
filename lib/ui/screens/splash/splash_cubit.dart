import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/common/blocs/main/main_cubit.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class SplashCubit extends Cubit<bool?> {
  final AppSettingRepository appSettingRepository;
  final MainCubit mainCubit;

  SplashCubit({required this.appSettingRepository, required this.mainCubit}) : super(null);

  void init() async {
    await Future.delayed(Duration(seconds: 2));
    final isFirstTime = await appSettingRepository.isFirstTimeOpenApp();
    if (!isFirstTime) {
      await mainCubit.init();
    }
    emit(isFirstTime);
  }
}
