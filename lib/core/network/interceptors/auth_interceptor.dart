import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // add your authorization key and value here
    options.headers["Authorization"] = "_KEY_";
    options.followRedirects = false;

    handler.next(options);
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      debugPrint("Handle user authorization");

      // handler.reject(err);
      // REJECT OR PASS
    }

    super.onError(err, handler);
  }
}