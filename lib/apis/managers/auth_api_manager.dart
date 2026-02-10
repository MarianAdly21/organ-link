import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/auth/login/login_send_model.dart';
import 'package:organ_link/apis/models/auth/login/login_successful_response.dart';

class AuthApiManager {
  final DioApiManager dioApiManager;

  AuthApiManager(this.dioApiManager);

  Future<void> loginApi(
    LoginSendModelApi loginSendModelApi,
    void Function(LoginSuccessfulResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dioUnauthorized
        .post(ApiKeys.loginUrl, data: loginSendModelApi.toMap())
        .then((response) {
          final Map<String, dynamic> extractedData = response.data;
          final LoginSuccessfulResponse loginSuccessfulResponse =
              LoginSuccessfulResponse.fromJson(extractedData);
          success(loginSuccessfulResponse);
        })
        .onError((DioException error, stackTrace) {
          if (error.type == DioExceptionType.badResponse) {
            fail(ErrorApiModel.fromLoginJson(error));
          } else {
            fail(ErrorApiModel.identifyError(error: error));
          }
        })
        .catchError((error) {
          final ErrorApiModel errorApiModel = ErrorApiModel.identifyError(
            error: error,
          );
          fail(errorApiModel);
        });
  }
}
