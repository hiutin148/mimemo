import 'package:mimemo/core/base/bases.dart';

class BottomNavCubit extends BaseCubit<int> {
  BottomNavCubit() : super(0);
  void switchTab(int index) {
    emit(index);
  }
}
