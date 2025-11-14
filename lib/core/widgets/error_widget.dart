import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_getx_starter/core/utils/styles/color.dart';

/// Widget untuk menampilkan error state
class ErrorWidget extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onRetry;
  final IconData? icon;

  const ErrorWidget({
    super.key,
    required this.message,
    this.buttonText,
    this.onRetry,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.error_outline,
              size: 64.sp,
              color: dangerColor,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(buttonText ?? 'Coba Lagi'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

