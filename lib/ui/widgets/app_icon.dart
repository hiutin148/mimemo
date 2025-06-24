import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({required this.icon, super.key, this.color, this.size = 24});

  final String icon;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Center(
        child: SvgPicture.asset(
          icon,
          width: size,
          height: size,
          colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}
