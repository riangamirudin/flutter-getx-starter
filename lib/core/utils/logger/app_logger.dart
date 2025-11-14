import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Logger utility untuk aplikasi
/// 
/// Menggunakan debugPrint di development dan bisa dikonfigurasi
/// untuk production logging
class AppLogger {
  static String? _packageName;
  static String _defaultTag = '[APP]';

  /// Initialize logger dengan package name dari device
  /// 
  /// Panggil method ini sekali di awal aplikasi (misalnya di main atau initial binding)
  /// Contoh: await AppLogger.init();
  static Future<void> init() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      _packageName = packageInfo.packageName;
      _defaultTag = '[$_packageName]';
    } catch (e) {
      // Jika gagal, gunakan default tag
      _defaultTag = '[APP]';
    }
  }

  /// Mendapatkan tag untuk logging
  static String get _tag => _packageName != null ? '[$_packageName]' : _defaultTag;

  /// Log level
  static bool _enableLog = kDebugMode;

  /// Enable atau disable logging
  static void setEnableLog(bool enable) {
    _enableLog = enable;
  }

  /// Log debug message
  static void d(String message, [String? tag]) {
    if (!_enableLog) return;
    debugPrint('${tag ?? _tag} [DEBUG] $message');
  }

  /// Log info message
  static void i(String message, [String? tag]) {
    if (!_enableLog) return;
    debugPrint('${tag ?? _tag} [INFO] $message');
  }

  /// Log warning message
  static void w(String message, [String? tag]) {
    if (!_enableLog) return;
    debugPrint('${tag ?? _tag} [WARNING] $message');
  }

  /// Log error message
  static void e(String message, [Object? error, StackTrace? stackTrace, String? tag]) {
    if (!_enableLog) return;
    debugPrint('${tag ?? _tag} [ERROR] $message');
    if (error != null) {
      debugPrint('${tag ?? _tag} Error: $error');
    }
    if (stackTrace != null) {
      debugPrint('${tag ?? _tag} StackTrace: $stackTrace');
    }
  }

  /// Log network request
  static void network(String method, String url, {Map<String, dynamic>? data}) {
    if (!_enableLog) return;
    debugPrint('${_tag} [NETWORK] $method $url');
    if (data != null) {
      debugPrint('${_tag} [NETWORK] Data: $data');
    }
  }

  /// Log network response
  static void networkResponse(String url, int statusCode, {dynamic data}) {
    if (!_enableLog) return;
    debugPrint('${_tag} [NETWORK] Response: $url - Status: $statusCode');
    if (data != null) {
      debugPrint('${_tag} [NETWORK] Response Data: $data');
    }
  }
}

