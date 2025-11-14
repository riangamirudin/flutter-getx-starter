import 'package:dio/dio.dart';
import 'package:flutter_getx_starter/core/network/dio_client.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';

/// Base class untuk semua remote datasource
/// 
/// Menyediakan method-method umum untuk melakukan API calls
abstract class BaseRemoteDataSource {
  final DioClient dioClient;

  BaseRemoteDataSource(this.dioClient);

  /// Method untuk melakukan GET request
  Future<T> get<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) mapper,
  }) async {
    AppLogger.network('GET', endpoint, data: queryParameters);
    
    T? result;
    await dioClient.safeRequest<T>(
      path: endpoint,
      queryParameters: queryParameters,
      mapper: mapper,
      onLoading: (status) {
        AppLogger.d('Loading: $endpoint');
      },
      onSuccess: (status) {
        result = status.data;
        AppLogger.networkResponse(endpoint, 200, data: status.data);
      },
      onError: (status) {
        AppLogger.e('Error: $endpoint - ${status.failure?.msgSystem}');
        throw status.failure!;
      },
    );
    
    return result!;
  }

  /// Method untuk melakukan POST request
  Future<T> post<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) mapper,
  }) async {
    AppLogger.network('POST', endpoint, data: data);
    
    T? result;
    await dioClient.safeRequest<T>(
      path: endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: 'POST'),
      mapper: mapper,
      onLoading: (status) {
        AppLogger.d('Loading: $endpoint');
      },
      onSuccess: (status) {
        result = status.data;
        AppLogger.networkResponse(endpoint, 200, data: status.data);
      },
      onError: (status) {
        AppLogger.e('Error: $endpoint - ${status.failure?.msgSystem}');
        throw status.failure!;
      },
    );
    
    return result!;
  }

  /// Method untuk melakukan PUT request
  Future<T> put<T>({
    required String endpoint,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) mapper,
  }) async {
    AppLogger.network('PUT', endpoint, data: data);
    
    T? result;
    await dioClient.safeRequest<T>(
      path: endpoint,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: 'PUT'),
      mapper: mapper,
      onLoading: (status) {
        AppLogger.d('Loading: $endpoint');
      },
      onSuccess: (status) {
        result = status.data;
        AppLogger.networkResponse(endpoint, 200, data: status.data);
      },
      onError: (status) {
        AppLogger.e('Error: $endpoint - ${status.failure?.msgSystem}');
        throw status.failure!;
      },
    );
    
    return result!;
  }

  /// Method untuk melakukan DELETE request
  Future<T> delete<T>({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic) mapper,
  }) async {
    AppLogger.network('DELETE', endpoint);
    
    T? result;
    await dioClient.safeRequest<T>(
      path: endpoint,
      queryParameters: queryParameters,
      options: Options(method: 'DELETE'),
      mapper: mapper,
      onLoading: (status) {
        AppLogger.d('Loading: $endpoint');
      },
      onSuccess: (status) {
        result = status.data;
        AppLogger.networkResponse(endpoint, 200, data: status.data);
      },
      onError: (status) {
        AppLogger.e('Error: $endpoint - ${status.failure?.msgSystem}');
        throw status.failure!;
      },
    );
    
    return result!;
  }
}

