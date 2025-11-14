import 'package:dio/dio.dart';
import 'package:flutter_getx_starter/core/errors/failures.dart';
import 'package:flutter_getx_starter/core/network/models/failure_model.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';

/// Utility untuk menangani error dan mengkonversinya menjadi Failure
class ErrorHandler {
  /// Mengkonversi error/exception menjadi Failure
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// try {
  ///   await apiCall();
  /// } catch (e) {
  ///   final failure = ErrorHandler.toFailure(e);
  ///   // Tampilkan error ke user
  ///   showError(ErrorHandler.getMessage(failure));
  /// }
  /// 
  /// // Atau dengan DioException
  /// try {
  ///   final response = await dio.get('/api/data');
  /// } on DioException catch (e) {
  ///   final failure = ErrorHandler.toFailure(e);
  ///   if (failure is AuthFailure) {
  ///     // Redirect ke login
  ///     navigateToLogin();
  ///   }
  /// }
  /// ```
  static Failure toFailure(dynamic error) {
    AppLogger.e('Error occurred', error);

    if (error is DioException) {
      return _handleDioError(error);
    }

    if (error is FailureModel) {
      return ServerFailure(error.msgShow ?? 'Terjadi kesalahan pada server.');
    }

    if (error is Failure) {
      return error;
    }

    return UnknownFailure(error.toString());
  }

  /// Menangani DioException
  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Koneksi timeout. Silakan coba lagi.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401) {
          return AuthFailure('Sesi Anda telah berakhir. Silakan login kembali.');
        } else if (statusCode == 403) {
          return PermissionFailure('Anda tidak memiliki akses untuk melakukan aksi ini.');
        } else if (statusCode == 404) {
          return ServerFailure('Data tidak ditemukan.');
        } else if (statusCode! >= 500) {
          return ServerFailure('Terjadi kesalahan pada server. Silakan coba lagi nanti.');
        } else {
          return ServerFailure(
            error.response?.data?['message'] ?? 'Terjadi kesalahan pada server.',
          );
        }

      case DioExceptionType.cancel:
        return NetworkFailure('Request dibatalkan.');

      case DioExceptionType.connectionError:
        return NetworkFailure('Tidak dapat terhubung ke server. Periksa koneksi internet Anda.');

      case DioExceptionType.badCertificate:
        return NetworkFailure('Sertifikat tidak valid.');

      case DioExceptionType.unknown:
        return NetworkFailure('Terjadi kesalahan yang tidak diketahui.');
    }
  }
}

