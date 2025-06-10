import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mimemo/core/extension/context_extension.dart';
import 'package:mimemo/core/extension/text_style_extension.dart';

abstract final class OverlayLoading {
  static OverlayEntry? _overlayEntry;
  static AnimationController? _controller;
  static bool _isVisible = false;

  static bool get isVisible => _isVisible;

  static Future<T> runWithLoading<T>(
      BuildContext context,
      Future<T> Function() asyncFunction, {
        String? message,
      }) async {
    try {
      OverlayLoading.show(context, message: message);
      final result = await asyncFunction();
      return result;
    } catch (e) {
      rethrow;
    } finally {
      unawaited(OverlayLoading.hide());
    }
  }

  static void show(BuildContext context, {String? message}) {
    if (_overlayEntry != null) return;

    _isVisible = true;
    _controller = AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 250),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return FadeTransition(
          opacity: _controller!,
          child: Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.black.withValues(alpha: 0.25),
              ),
              Center(
                child: Column(
                  spacing: 12,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (message != null)
                      Text(
                        message,
                        style:
                        context.textTheme.titleMedium?.white.w500,
                      ),
                    const CircularProgressIndicator(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller!.forward();
  }

  static Future<void> hide() async {
    if (_overlayEntry == null || _controller == null) return;

    await _controller!.reverse();
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    _controller!.dispose();
    _controller = null;
    _isVisible = false;
  }
}
