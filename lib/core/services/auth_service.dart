import 'package:get/get.dart';
import 'package:flutter_getx_starter/core/utils/hive/storage_service.dart';
import 'package:flutter_getx_starter/core/utils/constants/app_constants.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';

/// Service untuk mengelola autentikasi user
class AuthService extends GetxService {
  final RxBool isLoggedIn = false.obs;
  final RxString? token = RxString('');
  final RxString? refreshToken = RxString('');
  final RxString? userId = RxString('');

  @override
  void onInit() {
    super.onInit();
    _loadAuthData();
  }

  /// Load data autentikasi dari storage
  void _loadAuthData() {
    token?.value = HiveService.read(AppConstants.storageTokenKey) ?? '';
    refreshToken?.value = HiveService.read(AppConstants.storageRefreshTokenKey) ?? '';
    userId?.value = HiveService.read(AppConstants.storageUserIdKey) ?? '';
    isLoggedIn.value = HiveService.readObject<bool>(AppConstants.storageIsLoggedInKey) ?? false;
  }

  /// Menyimpan token autentikasi
  Future<void> saveToken(String newToken, {String? newRefreshToken}) async {
    await HiveService.write(AppConstants.storageTokenKey, newToken);
    token?.value = newToken;

    if (newRefreshToken != null) {
      await HiveService.write(AppConstants.storageRefreshTokenKey, newRefreshToken);
      refreshToken?.value = newRefreshToken;
    }

    await HiveService.writeObject(AppConstants.storageIsLoggedInKey, true);
    isLoggedIn.value = true;

    AppLogger.d('Token saved');
  }

  /// Menyimpan user ID
  Future<void> saveUserId(String id) async {
    await HiveService.write(AppConstants.storageUserIdKey, id);
    userId?.value = id;
  }

  /// Logout user
  Future<void> logout() async {
    await HiveService.remove(AppConstants.storageTokenKey);
    await HiveService.remove(AppConstants.storageRefreshTokenKey);
    await HiveService.remove(AppConstants.storageUserIdKey);
    await HiveService.remove(AppConstants.storageIsLoggedInKey);

    token?.value = '';
    refreshToken?.value = '';
    userId?.value = '';
    isLoggedIn.value = false;

    AppLogger.d('User logged out');
  }

  /// Mengecek apakah user sudah login
  bool get isAuthenticated {
    if (!isLoggedIn.value) return false;
    final tokenValue = token?.value;
    return tokenValue != null && tokenValue.isNotEmpty;
  }

  /// Mendapatkan token saat ini
  String? get currentToken => token?.value;

  /// Mendapatkan refresh token saat ini
  String? get currentRefreshToken => refreshToken?.value;

  /// Mendapatkan user ID saat ini
  String? get currentUserId => userId?.value;
}

