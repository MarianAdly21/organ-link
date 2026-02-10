import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/user_Home/user_home_data_response.dart';

class UserHomeApiManager {
  final DioApiManager dioApiManager;

  UserHomeApiManager(this.dioApiManager);
  Future<void> userHomeApi(
    int id,
    void Function(UserHomeDataResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getHomeUserUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final UserHomeDataResponse homeDataResponse =
              UserHomeDataResponse.formJson(extractedData);
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
