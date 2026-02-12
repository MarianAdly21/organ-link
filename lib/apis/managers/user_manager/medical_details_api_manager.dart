import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/user_models/medical_details/medical_details_api_model.dart';

class MedicalDetailsApiManager {
  final DioApiManager dioApiManager;

  MedicalDetailsApiManager({required this.dioApiManager});

   Future<void> medicalDetailsDataApi(
    int id,
    void Function(MedicalDetailsApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getMedicalDetailsUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final MedicalDetailsApiModel medicalDataResponse =
              MedicalDetailsApiModel.formJson(extractedData);
          success(medicalDataResponse);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

}