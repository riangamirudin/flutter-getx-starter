import 'package:dio/dio.dart';
import 'package:flutter_getx_starter/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_getx_starter/core/network/interceptors/basic_interceptor.dart';
import 'package:flutter_getx_starter/core/network/models/basic_model.dart';
import 'package:flutter_getx_starter/core/network/models/failure_model.dart';
import 'package:flutter_getx_starter/core/network/models/status_request_model.dart';

enum Method { post, get, put, delete, patch }

class DioClient {
  late final Dio _dio;

  DioClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        baseUrl: '_BASE_URL_',
        responseType: ResponseType.json,
        followRedirects: false,
        contentType: 'application/json',
        validateStatus: (status) => status == 200 || status == 201,
      ),
    )..interceptors.addAll([BasicInterceptor(), AuthInterceptor()]);
  }

  /// Fungsi ini digunakan untuk melakukan request ke server dan mengharapkan
  /// response dalam bentuk data yang bisa berupa **OBJEK** atau **LIST**.
  ///
  /// Dibutuhkan [path] yang merupakan alamat / URL (BASE URL + Endpoint)
  /// untuk memanggil permintaan ke API.
  ///
  /// Parameter [mapper] digunakan untuk melakukan konversi data response
  /// menjadi kelas model (T).
  /// - Jika response berupa objek tunggal → gunakan `ClassModel.fromJson`
  /// - Jika response berupa list → gunakan `List<ClassModel>.from(json.map((e) => ClassModel.fromJson(e)))`
  ///
  /// Untuk menangani status hasil permintaan, dibutuhkan beberapa callback:
  /// - [onLoading] → dipanggil ketika request mulai dijalankan (misalnya tampilkan loading indikator).
  /// - [onSuccess] → dipanggil ketika request berhasil dan data berhasil dipetakan.
  /// - [onError] → dipanggil ketika request gagal (baik karena error jaringan, server, atau mapping).
  /// - [onEmpty] (opsional) → dipanggil khusus ketika data berupa list kosong.
  ///
  /// Selain itu terdapat parameter opsional untuk mengatur request ke server:
  /// - [data] → body request (misalnya untuk POST/PUT/PATCH).
  /// - [queryParameters] → query string yang dikirim bersama URL. Contoh: `{"page": 1, "limit": 10}`
  /// - [options] → konfigurasi tambahan Dio, misalnya custom header (contoh: `Options(headers: {"Authorization": "Bearer token"})`).
  /// - [cancelToken] → digunakan untuk membatalkan request yang sedang berjalan.
  /// - [onSendProgress] → callback progress saat upload (misalnya upload file).
  /// - [onReceiveProgress] → callback progress saat download (misalnya download file).
  ///
  Future<void> safeRequest<T>({
    required String path,
    required Function(StatusRequestModel<T> value) onLoading,
    required Function(StatusRequestModel<T> value) onSuccess,
    required Function(StatusRequestModel<T> value) onError,
    Function(StatusRequestModel<T> value)? onEmpty, // optional untuk list
    required dynamic Function(dynamic json) mapper, // mapper fleksibel
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    onLoading(StatusRequestModel.loading());
    try {
      final response = await callApi(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      _handleResponse(
        response.data,
        onLoading: onLoading,
        onSuccess: (value) {
          try {
            final mapped = mapper(value);

            if (mapped is List && onEmpty != null) {
              if (mapped.isEmpty) {
                onEmpty(StatusRequestModel.empty());
              } else {
                onSuccess(StatusRequestModel.success(mapped as T));
              }
            } else {
              onSuccess(StatusRequestModel.success(mapped as T));
            }
          } catch (e) {
            onError(
              StatusRequestModel.error(
                FailureModel(
                  code: 9999,
                  msgShow: "Mapping error: ${e.toString()}",
                  msgSystem: "Mapping error: ${e.toString()}",
                ),
              ),
            );
          }
        },
        onError: onError,
      );
    } on DioException catch (e) {
      _handleResponseError({
        "code": e.response?.statusCode ?? 8000,
        "message": e.response?.statusMessage,
        "error": e.response?.data,
      }, onError);
    }
  }

  /// Fungsi ini digunakan untuk memanggil API menggunakan Dio.
  /// Fungsi ini bersifat **umum** sehingga dapat digunakan untuk berbagai method
  /// seperti GET, POST, PUT, PATCH, atau DELETE tergantung konfigurasi pada [options].
  ///
  /// Dibutuhkan [path] sebagai alamat endpoint (relative dari baseUrl) yang akan dipanggil.
  ///
  /// Parameter opsional:
  /// - [data] → body request, biasanya digunakan untuk method `POST`, `PUT`, atau `PATCH`.
  /// - [queryParameters] → parameter query yang akan ditambahkan pada URL.
  ///   Contoh: `{"page": 1, "limit": 20}` → `/users?page=1&limit=20`.
  /// - [options] → konfigurasi tambahan untuk request.
  ///   Misalnya: menentukan method (`Options(method: 'POST')`) atau custom header.
  /// - [cancelToken] → digunakan untuk membatalkan request yang sedang berjalan.
  /// - [onSendProgress] → callback progress saat **mengirim data** (misalnya upload file).
  /// - [onReceiveProgress] → callback progress saat **menerima data** (misalnya download file).
  ///
  /// Return: [Response] dari Dio yang berisi data response mentah dari server.
  ///
  Future<Response> callApi(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return await _dio.request(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Sebuah fungsi utilitas yang digunakan untuk menangani hasil response dari server.
  ///
  /// - [responseData] → hasil response dalam bentuk `Map<String, dynamic>` yang
  ///   diharapkan memiliki struktur standar:
  ///   - [BasicModel.BASIC_SUCCESS] → `true/false`, status keberhasilan request.
  ///   - [BasicModel.BASIC_DATA] → data yang dikembalikan jika request sukses.
  ///   - [BasicModel.BASIC_ERROR] → informasi error jika request gagal.
  ///
  /// Parameter callback:
  /// - [onLoading] → callback yang dijalankan saat request dalam keadaan *loading*.
  ///   Biasanya dipakai sebelum parsing data.
  /// - [onSuccess] → callback yang dijalankan jika `responseData` memiliki
  ///   `BASIC_SUCCESS == true`, dengan membawa nilai `BASIC_DATA`.
  /// - [onError] → callback yang dijalankan jika `BASIC_SUCCESS == false`,
  ///   dengan membawa objek `FailureModel` yang dibentuk dari `BASIC_ERROR`.
  ///
  /// Fungsi ini akan otomatis memanggil [_handleResponseError] jika response gagal.
  static _handleResponse<T>(
    Map<String, dynamic> responseData, {
    required Function(StatusRequestModel<T> value) onLoading,
    required Function(dynamic value) onSuccess,
    required Function(StatusRequestModel<T> value) onError,
  }) {
    if (responseData[BasicModel.BASIC_SUCCESS] == true) {
      onSuccess(responseData[BasicModel.BASIC_DATA]);
    } else {
      _handleResponseError(responseData[BasicModel.BASIC_ERROR], onError);
    }
  }

  /// Sebuah fungsi utilitas yang digunakan untuk menangani response error dari server.
  ///
  /// - [response] → data error dari server (biasanya berupa `Map<String, dynamic>`),
  ///   yang akan dikonversi menjadi [FailureModel] melalui `FailureModel.fromJson`.
  ///
  /// - [onError] → callback yang dijalankan ketika terjadi error.
  ///   Callback ini akan dipanggil dengan `StatusRequestModel.error` yang
  ///   berisi instance dari [FailureModel].
  ///
  /// Fungsi ini berguna agar error dari server bisa ditangani secara konsisten
  /// dalam bentuk model error yang seragam.
  static _handleResponseError<T>(dynamic response, Function(StatusRequestModel<T> value) onError) {
    FailureModel error = FailureModel.fromJson(response);
    onError(StatusRequestModel.error(error));
  }
}
