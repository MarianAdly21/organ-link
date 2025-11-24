import 'dart:developer';

import 'package:dio/dio.dart';

class RequestFormDataInterceptor extends Interceptor {
  RequestFormDataInterceptor();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.data is FormData) {
      log("Request Form Data:");
      final formData = options.data as FormData;
      log(formData.fields.toString());
    } else {
      log("Not Form Data Request:");
    }
    handler.next(options);
  }
}
