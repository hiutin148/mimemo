import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class SplashCubit extends Cubit<bool?> {
  final AppSettingRepository appSettingRepository;

  SplashCubit({required this.appSettingRepository}) : super(null);

  void init() async {
    await Future.delayed(Duration(seconds: 2));
    final isFirstTime = await appSettingRepository.isFirstTimeOpenApp();
    emit(isFirstTime);
  }
}
