import 'package:flutter/material.dart';
import 'package:mimemo/core/const/consts.dart';

class AppRefreshIndicator extends StatelessWidget {
  const AppRefreshIndicator({required this.child, required this.onRefresh, super.key});

  final Widget child;
  final RefreshCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: AppColors.primary,
      backgroundColor: Colors.white,
      child: child,
    );
  }
}
