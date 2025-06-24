import 'package:flutter/material.dart';

class AppInkWell extends StatelessWidget {
  const AppInkWell({
    required this.child,
    super.key,
    this.onTap,
    this.padding,
    this.decoration,
    this.width,
    this.height,
    this.borderRadius,
  });

  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration?.copyWith(borderRadius: BorderRadius.circular(borderRadius ?? 0)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          onTap: onTap,
          child: Ink(width: width, height: height, padding: padding, child: child),
        ),
      ),
    );
  }
}
