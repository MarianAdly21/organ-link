import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:organ_link/apis/_base/refresh_token_api_manager.dart';
import 'package:organ_link/apis/_base/request_form_data_interceptor.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/models/refresh_token/refresh_token_send_model_api.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/utils/build_type/build_type.dart';
import 'package:organ_link/utils/extensions/extension_string.dart';

class DioApiManager {
  final PreferencesManager preferenceManager;
  final VoidCallback failToRefreshTokenCallback;

  //  dio instance to request token
  DioApiManager({
    required this.preferenceManager,
    required this.failToRefreshTokenCallback,
  });

  bool canRefreshToken = true;

  final LogInterceptor _logInterceptor = LogInterceptor(
    responseBody: true,
    requestBody: true,
    error: true,
    logPrint: (obj) {
      log(obj.toString());
    },
  );

  Dio get dioUnauthorized {
    return DioOptions.dioInstance(optionsUnauthorized)
      ..interceptors.clear()
      ..interceptors.addAll([
        _queuedInterceptorsWrapperUnauthorized,
        if (isDebugMode()) ...[_logInterceptor, RequestFormDataInterceptor()],
      ]);
  }

  Dio get dio {
    return DioOptions.dioInstance(options)
      ..interceptors.clear()
      ..interceptors.addAll([
        _queuedInterceptorsWrapper,
        if (isDebugMode()) ...[_logInterceptor, RequestFormDataInterceptor()],
      ]);
  }

  // todo --> handle this in a different class ...
  QueuedInterceptorsWrapper get _queuedInterceptorsWrapper {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) async {
        final String language = await preferenceManager.getLocale() ?? "ar";
        if (request.headers[ApiKeys.locale] != language) {
          request.headers[ApiKeys.locale] = language;
        }
        final String? token = await preferenceManager.getAccessToken();
        if (!token.isNullOrEmpty) {
          if (request.headers[ApiKeys.authorization] == null) {
            request.headers[ApiKeys.authorization] =
                '${ApiKeys.keyBearer} $token';
          }
        }
        return handler.next(request);
      },
      onResponse: (e, handler) {
        if (e.statusCode == 200) {
          canRefreshToken = true;
        }
        return handler.next(e);
      },
      onError: (error, handler) async {
        // Assume 401 stands for token expired
        if (error.response?.statusCode == 401 && canRefreshToken) {
          canRefreshToken = false;
          final options = error.response!.requestOptions;
          final String? refreshToken = (await preferenceManager
              .getRefreshToken());
          if (refreshToken == null) {
            handler.reject(error);
            failToRefreshTokenCallback();
            return;
          }
          await RefreshTokenApiManager(dioUnauthorized).refreshTokenApi(
            RefreshTokenSendModelApi(refreshToken),
            (refreshTokenWrapper) async {
              // update token
              await preferenceManager.setTokenData(
                refreshTokenWrapper.data!.accessToken,
                refreshTokenWrapper.data!.refreshToken,
                refreshTokenWrapper.data!.expiresIn,
              );
              options.headers[ApiKeys.authorization] =
                  '${ApiKeys.keyBearer} ${refreshTokenWrapper.data!.accessToken}';
              await dio
                  .fetch(options)
                  .then(
                    (r) => handler.resolve(r),
                    onError: (e) {
                      handler.reject(e);
                    },
                  );
            },
            (errorApiModel) {
              handler.reject(error);
              failToRefreshTokenCallback();
            },
          );
          return;
        }
        return handler.next(error);
      },
    );
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapperUnauthorized {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) async {
        final String? language = await preferenceManager.getLocale();
        if (request.headers[ApiKeys.locale] != language) {
          request.headers[ApiKeys.locale] = language ?? "en";
        }
        if (request.headers[ApiKeys.acceptLanguage] != language) {
          request.headers[ApiKeys.acceptLanguage] = language ?? "en";
        }
        return handler.next(request);
      },
    );
  }

  DioOptions options = DioOptions();
  DioOptions optionsUnauthorized = DioOptions();
}

class DioOptions extends BaseOptions {
  @override
  Map<String, dynamic> get headers {
    final Map<String, dynamic> header = {};

    header.putIfAbsent(ApiKeys.accept, () => ApiKeys.applicationJson);

    return header;
  }

  @override
  String get baseUrl => ApiKeys.baseUrl;

  static Dio? dio;

  static Dio dioInstance(BaseOptions options) {
    dio ??= Dio(options);

    return dio!;
  }
}
