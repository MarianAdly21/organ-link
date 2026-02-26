import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/user_models/user_data_response.dart';

class UserApiManager {
  final DioApiManager dioApiManager;

  UserApiManager(this.dioApiManager);
  Future<void> getUserDataApi(
    int id,
    void Function(UserDataResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final UserDataResponse homeDataResponse =
              UserDataResponse.formJson(extractedData);
          success(homeDataResponse);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

}
