import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/hospital/hospital_data_response.dart';
import 'package:organ_link/apis/models/hospital/matching_details_api_model.dart';
import 'package:organ_link/apis/models/hospital/surger_details_api_model.dart';

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

  Future<void> getMatchingDetailsDataApi(
    int id,
    void Function(MatchingDetailsApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getMatchingDetailsUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final MatchingDetailsApiModel matchingDetailsApiModel =
              MatchingDetailsApiModel.formJson(extractedData);
          success(matchingDetailsApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getSurgeryDetailsDataApi(
    int id,
    void Function(SurgerDetailsApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getSurgerDetailsUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final SurgerDetailsApiModel surgerDetailsApiModel =
              SurgerDetailsApiModel.formJson(extractedData);
          success(surgerDetailsApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }
}
