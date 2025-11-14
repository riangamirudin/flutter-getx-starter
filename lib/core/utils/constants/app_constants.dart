/// Constants untuk aplikasi
class AppConstants {
  AppConstants._();

  // Storage Keys
  static const String storageTokenKey = 'auth_token';
  static const String storageRefreshTokenKey = 'refresh_token';
  static const String storageUserIdKey = 'user_id';
  static const String storageIsLoggedInKey = 'is_logged_in';
  static const String storageThemeKey = 'theme_mode';
  static const String storageLanguageKey = 'language';
  static const String localHiveDatabase = 'LOCAL_HIVE_DATABASE';

  // API
  static const int connectTimeout = 60000;
  static const int receiveTimeout = 60000;
  static const String apiVersion = 'v1';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 50;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;

  // Date Format
  static const String dateFormat = 'dd/MM/yyyy';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';
  static const String timeFormat = 'HH:mm';
  static const String isoDateFormat = 'yyyy-MM-dd';

  // Currency
  static const String currencySymbol = 'Rp ';
  static const String currencyCode = 'IDR';

  // File
  static const int maxFileSize = 10 * 1024 * 1024; // 10 MB
  static const List<String> allowedImageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> allowedDocumentExtensions = ['pdf', 'doc', 'docx', 'xls', 'xlsx'];

  // Regex Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^(\+62|62|0)[0-9]{9,12}$';
  static const String urlPattern = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  // Animation Duration
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Debounce Duration
  static const Duration debounceDuration = Duration(milliseconds: 500);
}

