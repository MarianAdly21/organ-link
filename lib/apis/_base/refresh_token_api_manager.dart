import 'package:dio/dio.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/refresh_token/refresh_token_send_model_api.dart';
import 'package:organ_link/apis/models/refresh_token/refresh_token_wrapper.dart';

class RefreshTokenApiManager {
  final Dio dio;

  RefreshTokenApiManager(this.dio);

  Future<void> refreshTokenApi(
    RefreshTokenSendModelApi refreshTokenSendModelApi,
    Future<void> Function(RefreshTokenWrapper) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dio
        .post(ApiKeys.loginUrl, data: refreshTokenSendModelApi.toMap())
        .then((response) async {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final RefreshTokenWrapper wrapper = RefreshTokenWrapper.fromJson(
            extractedData,
          );
          await success(wrapper);
        })
        .catchError((onError) {
          fail(ErrorApiModel.identifyError(error: onError));
        });
  }
}
