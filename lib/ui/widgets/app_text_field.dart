import 'package:flutter/material.dart';
import 'package:mimemo/core/extension/extensions.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.hintText,
    this.onChanged,
    this.borderRadius,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? hintText;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white12,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius ?? 4),
        ),
        hintText: hintText,
        hintStyle: context.textTheme.bodySmall?.copyWith(
          color: Colors.white24,
        ),
      ),
      style: context.textTheme.bodySmall,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}
