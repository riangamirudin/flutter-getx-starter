import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';

/// Service untuk menampilkan notifikasi/alert
class NotificationService extends GetxService {
  /// Menampilkan snackbar success
  void showSuccess(String message, {Duration? duration}) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
    AppLogger.i('Success notification: $message');
  }

  /// Menampilkan snackbar error
  void showError(String message, {Duration? duration}) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.error, color: Colors.white),
    );
    AppLogger.e('Error notification: $message');
  }

  /// Menampilkan snackbar warning
  void showWarning(String message, {Duration? duration}) {
    Get.snackbar(
      'Peringatan',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.warning, color: Colors.white),
    );
    AppLogger.w('Warning notification: $message');
  }

  /// Menampilkan snackbar info
  void showInfo(String message, {Duration? duration}) {
    Get.snackbar(
      'Info',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: duration ?? const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
      icon: const Icon(Icons.info, color: Colors.white),
    );
    AppLogger.i('Info notification: $message');
  }

  /// Menampilkan dialog konfirmasi
  Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = 'Ya',
    String cancelText = 'Tidak',
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Menampilkan loading dialog
  void showLoading({String? message}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(message),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  /// Menutup loading dialog
  void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}

