import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/ministry/hospitals_list/hospitals_list_api_model.dart';
import 'package:organ_link/apis/models/ministry/ministry_dashboard/ministry_dashboard_response.dart';

class MinistryApiManager {
  final DioApiManager dioApiManager;

  MinistryApiManager({required this.dioApiManager});

  Future<void> getMinistryDashboardData(
    void Function(MinistryDashboardResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.ministryDashboardUrl)
        .then((response) {
          final Map<String, dynamic> extractedData = response.data;
          final MinistryDashboardResponse ministryDashboardResponse =
              MinistryDashboardResponse.fromJson(extractedData);
          success(ministryDashboardResponse);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getHospitalsListData(
    void Function(HospitalsListApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.ministryDashboardUrl)
        .then((response) {
          final Map<String, dynamic> extractedData = response.data;
          final HospitalsListApiModel hospitalsListApiModel =
              HospitalsListApiModel.fromJson(extractedData);
          success(hospitalsListApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }
}
