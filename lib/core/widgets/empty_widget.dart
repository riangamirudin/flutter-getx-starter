import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widget untuk menampilkan empty state
class EmptyWidget extends StatelessWidget {
  final String message;
  final String? buttonText;
  final VoidCallback? onAction;
  final IconData? icon;

  const EmptyWidget({
    super.key,
    required this.message,
    this.buttonText,
    this.onAction,
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
              icon ?? Icons.inbox_outlined,
              size: 64.sp,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null && buttonText != null) ...[
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

