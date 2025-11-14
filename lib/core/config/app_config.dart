import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';

/// Konfigurasi aplikasi berdasarkan environment
/// 
/// Menggunakan file .env untuk menyimpan konfigurasi
/// 
/// **Struktur file .env yang diperlukan:**
/// ```env
/// # Environment Configuration
/// APP_ENV=development
/// 
/// # API Base URLs
/// API_BASE_URL_DEV=https://api-dev.example.com
/// API_BASE_URL_STAGING=https://api-staging.example.com
/// API_BASE_URL_PROD=https://api.example.com
/// 
/// # Network Configuration
/// CONNECT_TIMEOUT=60000
/// RECEIVE_TIMEOUT=60000
/// 
/// # API Configuration
/// API_VERSION=v1
/// 
/// # App Information
/// APP_VERSION=1.0.0
/// APP_BUILD_NUMBER=1
/// ```
/// 
/// **Contoh penggunaan:**
/// ```dart
/// // 1. Load .env di main.dart sebelum runApp
/// await dotenv.load(fileName: ".env");
/// 
/// // 2. Initialize AppConfig
/// AppConfig.init();
/// 
/// // 3. Gunakan config
/// final baseUrl = AppConfig.baseUrl;
/// final isDev = AppConfig.isDevelopment;
/// final timeout = AppConfig.connectTimeout;
/// ```
class AppConfig {
  static AppEnvironment _environment = AppEnvironment.development;
  static String _baseUrl = '';
  static bool _initialized = false;

  /// Initialize AppConfig dari .env file
  /// 
  /// **Pastikan dotenv sudah di-load sebelum memanggil method ini**
  /// 
  /// Contoh di main.dart:
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   
  ///   // Load .env file
  ///   await dotenv.load(fileName: ".env");
  ///   
  ///   // Initialize AppConfig
  ///   AppConfig.init();
  ///   
  ///   runApp(MyApp());
  /// }
  /// ```
  /// 
  /// **File .env harus berada di root project dan sudah ditambahkan ke assets di pubspec.yaml:**
  /// ```yaml
  /// flutter:
  ///   assets:
  ///     - .env
  /// ```
  static void init() {
    if (_initialized) return;

    try {
      // Baca environment dari .env
      final envString = dotenv.get('APP_ENV', fallback: 'development');
      _environment = _parseEnvironment(envString);

      // Setup konfigurasi berdasarkan environment
      _setupConfig();

      _initialized = true;
      AppLogger.i('AppConfig initialized');
      AppLogger.i('Environment: $_environment');
      AppLogger.i('Base URL: $_baseUrl');
    } catch (e) {
      AppLogger.e('Failed to initialize AppConfig', e);
      // Fallback ke default values
      _environment = AppEnvironment.development;
      _setupConfig();
    }
  }

  /// Parse string environment menjadi AppEnvironment
  static AppEnvironment _parseEnvironment(String env) {
    switch (env.toLowerCase()) {
      case 'development':
      case 'dev':
        return AppEnvironment.development;
      case 'staging':
      case 'stage':
        return AppEnvironment.staging;
      case 'production':
      case 'prod':
        return AppEnvironment.production;
      default:
        return AppEnvironment.development;
    }
  }

  /// Set environment aplikasi secara manual
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// AppConfig.setEnvironment(AppEnvironment.production);
  /// ```
  static void setEnvironment(AppEnvironment env) {
    _environment = env;
    _setupConfig();
    AppLogger.i('Environment changed to: $_environment');
  }

  /// Setup konfigurasi berdasarkan environment dari .env
  static void _setupConfig() {
    try {
      switch (_environment) {
        case AppEnvironment.development:
          _baseUrl = dotenv.get('API_BASE_URL_DEV', fallback: 'https://api-dev.example.com');
          break;
        case AppEnvironment.staging:
          _baseUrl = dotenv.get('API_BASE_URL_STAGING', fallback: 'https://api-staging.example.com');
          break;
        case AppEnvironment.production:
          _baseUrl = dotenv.get('API_BASE_URL_PROD', fallback: 'https://api.example.com');
          break;
      }
    } catch (e) {
      AppLogger.e('Failed to setup config from .env', e);
      // Fallback ke hardcoded values
      switch (_environment) {
        case AppEnvironment.development:
          _baseUrl = 'https://api-dev.example.com';
          break;
        case AppEnvironment.staging:
          _baseUrl = 'https://api-staging.example.com';
          break;
        case AppEnvironment.production:
          _baseUrl = 'https://api.example.com';
          break;
      }
    }
  }

  /// Mendapatkan base URL dari .env
  static String get baseUrl => _baseUrl;

  /// Mendapatkan environment saat ini
  static AppEnvironment get environment => _environment;

  /// Mengecek apakah dalam mode development
  static bool get isDevelopment => _environment == AppEnvironment.development;

  /// Mengecek apakah dalam mode staging
  static bool get isStaging => _environment == AppEnvironment.staging;

  /// Mengecek apakah dalam mode production
  static bool get isProduction => _environment == AppEnvironment.production;

  /// Timeout untuk network request (dalam milliseconds) dari .env
  static int get connectTimeout {
    try {
      return int.parse(dotenv.get('CONNECT_TIMEOUT', fallback: '60000'));
    } catch (e) {
      AppLogger.e('Failed to parse CONNECT_TIMEOUT', e);
      return 60000;
    }
  }

  /// Timeout untuk receive request (dalam milliseconds) dari .env
  static int get receiveTimeout {
    try {
      return int.parse(dotenv.get('RECEIVE_TIMEOUT', fallback: '60000'));
    } catch (e) {
      AppLogger.e('Failed to parse RECEIVE_TIMEOUT', e);
      return 60000;
    }
  }

  /// API version dari .env
  static String get apiVersion => dotenv.get('API_VERSION', fallback: 'v1');

  /// App version dari .env
  static String get appVersion => dotenv.get('APP_VERSION', fallback: '1.0.0');

  /// Build number dari .env
  static String get buildNumber => dotenv.get('APP_BUILD_NUMBER', fallback: '1');
}

enum AppEnvironment {
  development,
  staging,
  production,
}

