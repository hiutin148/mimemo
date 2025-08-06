import 'package:flutter/material.dart';
import 'package:mimemo/core/const/consts.dart';
import 'package:mimemo/ui/widgets/widgets.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    required this.child,
    required this.title,
    this.onTap,
    super.key,
    this.cardContentPadding = 16,
  });

  final Widget child;
  final String title;
  final VoidCallback? onTap;
  final double cardContentPadding;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onTap,
      borderRadius: 8,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (onTap != null)
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  ),
              ],
            ),
          ),
          const Divider(
            color: AppColors.surface,
            height: 1,
            thickness: 0.5,
          ),
          Padding(
            padding: EdgeInsets.all(cardContentPadding),
            child: child,
          ),
        ],
      ),
    );
  }
}
