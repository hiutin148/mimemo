import 'package:flutter/material.dart';
import 'package:mimemo/core/extension/context_extension.dart';
import 'package:mimemo/core/extension/text_style_extension.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.child,
    this.title = '',
    this.onPressed,
    this.height,
    this.width,
    this.radius = 8,
    this.backgroundColor = Colors.white24,
    this.padding = EdgeInsets.zero,
    this.borderSide = BorderSide.none,
    this.titleStyle,
    this.enable = true,
    this.disabledBackgroundColor,
  });

  final Widget? child;
  final String title;
  final Function()? onPressed;
  final double? height;
  final double? width;
  final double radius;
  final Color backgroundColor;
  final Color? disabledBackgroundColor;
  final EdgeInsets padding;
  final BorderSide borderSide;
  final TextStyle? titleStyle;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: borderSide,
        ),
        backgroundColor: backgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        padding: padding,
        minimumSize: const Size.square(0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: enable ? onPressed : null,
      child: SizedBox(
        height: height,
        width: width,
        child: Center(
          child:
              child ?? Text(title, style: titleStyle ?? context.textTheme.titleMedium?.w500.white),
        ),
      ),
    );
  }
}
