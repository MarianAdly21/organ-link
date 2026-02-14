import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/hospital/hospital_data_response.dart';

class HospitalApiManager {
  final DioApiManager dioApiManager;

  HospitalApiManager({required this.dioApiManager});

  Future<void> getHospitalDataApi(
    int id,
    void Function(HospitalDataResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getHospitalUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final HospitalDataResponse hospitalDataResponse =
              HospitalDataResponse.formJson(extractedData);
          success(hospitalDataResponse);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

}
