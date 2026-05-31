import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/user_models/case_follow_up_api_model.dart';
import 'package:organ_link/apis/models/user_models/hospital_information_user_api_model.dart';
import 'package:organ_link/apis/models/user_models/medical_details_api_model.dart';
import 'package:organ_link/apis/models/user_models/schedule_procedure_api_model.dart';
import 'package:organ_link/apis/models/user_models/user_data_response.dart';

class UserApiManager {
  final DioApiManager dioApiManager;

  UserApiManager(this.dioApiManager);
  Future<void> getUserHomeDataApi(
    int id,
    void Function(UserDataResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final UserDataResponse homeDataResponse = UserDataResponse.formJson(
            extractedData,
          );
          success(homeDataResponse);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getMedicalDetailsDataApi(
    int id,
    void Function(MedicalDetailsApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final MedicalDetailsApiModel medicalDetailsApiModel =
              MedicalDetailsApiModel.formJson(extractedData);
          success(medicalDetailsApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getScheduleProcedureDataApi(
    int id,
    void Function(ScheduleProcedureApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final ScheduleProcedureApiModel scheduleProcedureApiModel =
              ScheduleProcedureApiModel.formJson(extractedData);
          success(scheduleProcedureApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getHospitalDetailsDataApi(
    int id,
    void Function(HospitalInformationUserApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final HospitalInformationUserApiModel
          hospitalInformationUserApiModel =
              HospitalInformationUserApiModel.formJson(extractedData);
          success(hospitalInformationUserApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> caseFollowUpApi(
    int id,
    void Function(CaseFollowUpApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final CaseFollowUpApiModel caseFollowUpApiModel =
              CaseFollowUpApiModel.formJson(extractedData);
          success(caseFollowUpApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }
}
