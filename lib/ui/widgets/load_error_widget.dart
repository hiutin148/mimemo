import 'package:flutter/material.dart';
import 'package:mimemo/core/extension/extensions.dart';

class LoadErrorWidget extends StatelessWidget {
  const LoadErrorWidget({required this.onRetry, super.key, this.message});

  final VoidCallback onRetry;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 48,
            color: Colors.white54,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? 'Some errors occurred',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
