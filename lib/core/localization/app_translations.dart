import 'package:get/get.dart';

/// Kelas yang berisi seluruh translasi aplikasi untuk GetX.
///
/// ## Cara Menggunakan
/// **Di main.dart:**
/// ```dart
/// GetMaterialApp(
///   translations: AppTranslations(),
///   locale: const Locale('id', 'ID'),
///   fallbackLocale: const Locale('en', 'US'),
/// )
/// ```
///
/// ## Contoh Penggunaan di View / Widget
/// ```dart
/// Text('app_name'.tr);
/// Text('loading'.tr);
/// BaseButton(text: 'save'.tr);
/// AppBar(title: Text('app_name'.tr));
/// Get.snackbar('success'.tr, 'Data berhasil disimpan');
/// ```
///
/// ## Contoh Penggunaan di Controller
/// ```dart
/// class MyController extends GetxController {
///   void showError() {
///     Get.snackbar('error'.tr, 'network_error'.tr);
///   }
///
///   String get welcomeMessage => 'welcome'.tr;
/// }
/// ```
///
/// ## Mengganti Bahasa
/// ```dart
/// Get.updateLocale(const Locale('id', 'ID'));
/// Get.updateLocale(const Locale('en', 'US'));
/// ```
///
/// ## Menyimpan Preferensi Bahasa
/// ```dart
/// await HiveService.write('language', 'id_ID');
/// final saved = HiveService.read('language') ?? 'id_ID';
/// Get.updateLocale(Locale(saved.split('_')[0], saved.split('_')[1]));
/// ```
///
/// ## Mendapatkan Bahasa Saat Ini
/// ```dart
/// final locale = Get.locale;        // Locale('id', 'ID')
/// final lang = Get.locale?.languageCode; // 'id'
/// final country = Get.locale?.countryCode; // 'ID'
/// ```
class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'id_ID': {
      // Common
      'app_name': 'Flutter GetX Starter',
      'loading': 'Memuat...',
      'error': 'Terjadi kesalahan',
      'success': 'Berhasil',
      'cancel': 'Batal',
      'confirm': 'Konfirmasi',
      'save': 'Simpan',
      'delete': 'Hapus',
      'edit': 'Edit',
      'add': 'Tambah',
      'search': 'Cari',
      'no_data': 'Tidak ada data',
      'retry': 'Coba Lagi',

      // Auth
      'login': 'Masuk',
      'logout': 'Keluar',
      'register': 'Daftar',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Lupa Password?',

      // Validation
      'required_field': 'Field ini wajib diisi',
      'invalid_email': 'Format email tidak valid',
      'invalid_phone': 'Format nomor telepon tidak valid',
      'password_too_short': 'Password minimal 8 karakter',

      // Error messages
      'network_error': 'Terjadi kesalahan koneksi',
      'server_error': 'Terjadi kesalahan pada server',
      'unknown_error': 'Terjadi kesalahan yang tidak diketahui',
    },

    'en_US': {
      // Common
      'app_name': 'Flutter GetX Starter',
      'loading': 'Loading...',
      'error': 'An error occurred',
      'success': 'Success',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'add': 'Add',
      'search': 'Search',
      'no_data': 'No data',
      'retry': 'Retry',

      // Auth
      'login': 'Login',
      'logout': 'Logout',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'forgot_password': 'Forgot Password?',

      // Validation
      'required_field': 'This field is required',
      'invalid_email': 'Invalid email format',
      'invalid_phone': 'Invalid phone number format',
      'password_too_short': 'Password must be at least 8 characters',

      // Error messages
      'network_error': 'Network connection error',
      'server_error': 'Server error occurred',
      'unknown_error': 'Unknown error occurred',
    },
  };
}
