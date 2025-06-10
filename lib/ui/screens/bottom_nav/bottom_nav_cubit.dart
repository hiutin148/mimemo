import 'package:flutter/cupertino.dart';
import 'package:mimemo/core/base/bases.dart';

class BottomNavCubit extends BaseCubit<int> {
  BottomNavCubit() : super(0);
  final PageController pageController = PageController();

  void switchTab(int index) {
    emit(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
