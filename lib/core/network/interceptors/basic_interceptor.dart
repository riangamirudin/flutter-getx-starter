import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BasicInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint(
      '\n╔══════════════════════════ REQUEST ══════════════════════════\n'
      '╟ REQUEST ║ ${options.method.toUpperCase()}\n'
      '╟ url: ${options.path.toString()}\n'
      '╟ Headers: ${options.headers}\n'
      '╟ QueryParameters: ${options.queryParameters}\n'
      '╟ BodyData: ${options.data.toString()}'
      '\n╚══════════════════════════ END REQUEST ══════════════════════\n',
      wrapWidth: 1024,
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '\n╔══════════════════════════ RESPONSE ══════════════════════════\n'
      '╟ url: ${response.requestOptions.path.toString()}\n'
      '╟ Data ║ ${response.data}'
      '\n╚══════════════════════════ END RESPONSE ══════════════════════\n',
      wrapWidth: 1024,
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}