import 'package:flutter/material.dart';
import 'package:mimemo/core/extension/extensions.dart';

abstract final class DialogUtil {
  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    String? title,
    String? message,
    String agreeText = 'Agree',
    String disagreeText = 'Disagree',
    VoidCallback? onAgree,
    VoidCallback? onDisagree,
    Color? agreeButtonColor,
    Color? disagreeButtonColor,
    bool barrierDismissible = true,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.w500,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],

                if (message != null) ...[
                  Text(
                    message,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 24),
                ],

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (onDisagree != null) {
                            onDisagree();
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop(false);
                          }
                        },
                        style: TextButton.styleFrom(
                          foregroundColor:
                              disagreeButtonColor ??
                              Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                            ),
                          ),
                        ),
                        child: Text(
                          disagreeText,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (onAgree != null) {
                            onAgree();
                            Navigator.of(context).pop();
                          } else {
                            Navigator.of(context).pop(true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              agreeButtonColor ?? Theme.of(context).colorScheme.primary,
                          foregroundColor: Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          agreeText,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
