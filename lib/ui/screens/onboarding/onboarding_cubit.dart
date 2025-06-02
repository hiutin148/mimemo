import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mimemo/repositories/app_setting_repository.dart';

class OnboardingCubit extends Cubit<void> {
  final AppSettingRepository appSettingRepository;

  OnboardingCubit({required this.appSettingRepository}) : super(null);

  void setIsFirstOpen() {
    appSettingRepository.setIsFirstTimeOpenApp(false);
  }
}
