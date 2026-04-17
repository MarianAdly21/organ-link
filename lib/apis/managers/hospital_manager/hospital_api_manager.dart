import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/api_keys.dart';
import 'package:organ_link/apis/errors/error_api_model.dart';
import 'package:organ_link/apis/models/hospital/hospital_data_response.dart';
import 'package:organ_link/apis/models/hospital/hospital_notification/hospital_notification_api_model.dart';
import 'package:organ_link/apis/models/hospital/matches/match_api_model.dart';
import 'package:organ_link/apis/models/hospital/matching_details_api_model.dart';
import 'package:organ_link/apis/models/hospital/patient_or_donor_details_api_model.dart';
import 'package:organ_link/apis/models/hospital/patient_or_donor_list/patient_or_donor_list_api_model.dart';
import 'package:organ_link/apis/models/hospital/surger_details_api_model.dart';
import 'package:organ_link/apis/models/hospital/surgeries/surgery_api_model.dart';
import 'package:organ_link/apis/models/hospital/upload_file/upload_file_response.dart';
import 'package:organ_link/apis/models/hospital/upload_file/upload_file_send_api_model.dart';

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

  Future<void> getPatientOrDonorDetailsDataApi(
    int id,
    void Function(PatientOrDonorDetailsApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getUserDataUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final PatientOrDonorDetailsApiModel patientOrDonorDetailsApiModel =
              PatientOrDonorDetailsApiModel.formJson(extractedData);
          success(patientOrDonorDetailsApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getPatientsOrDonorsListApi(
    int id,
    void Function(PatientOrDonorListApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getHospitalUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final PatientOrDonorListApiModel patientOrDonorListApiModel =
              PatientOrDonorListApiModel.formJson(extractedData);
          success(patientOrDonorListApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getSurgeriesDataApi(
    int id,
    void Function(SurgeryApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getHospitalUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final SurgeryApiModel surgeryApiModel = SurgeryApiModel.fromJson(
            extractedData,
          );
          success(surgeryApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getMatchesDataApi(
    int id,
    void Function(MatchApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getHospitalUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final MatchApiModel matchApiModel = MatchApiModel.fromJson(
            extractedData,
          );
          success(matchApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> getHospitalNotificationDataApi(
    int id,
    void Function(HospitalNotificationApiModel) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .get(ApiKeys.getHospitalUrl(id))
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final HospitalNotificationApiModel hospitalNotificationApiModel =
              HospitalNotificationApiModel.fromJson(extractedData);
          success(hospitalNotificationApiModel);
        })
        .onError((DioException error, stackTrace) {
          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }

  Future<void> uploadReportApi(
    UploadFileSendApiModel uploadFileSendApiModel,
    String token,
    void Function(UploadFileResponse) success,
    void Function(ErrorApiModel) fail,
  ) async {
    await dioApiManager.dio
        .post(
          "https://web-production-b0489.up.railway.app/api/UserReport/",
         // ApiKeys.uploadUserReport,
          data: await uploadFileSendApiModel.toFormData(),
          options: Options(headers: {"Authorization": "Bearer $token"}),
        )
        .then((response) {
          final Map<String, dynamic> extractedData =
              response.data as Map<String, dynamic>;
          final UploadFileResponse uploadFileResponse =
              UploadFileResponse.fromJson(extractedData);
          success(uploadFileResponse);
        })
        .onError((DioException error, stackTrace) {
          log("ERROR DATA: ${error.response?.data}");
          log("uploadUserReport: ${ApiKeys.uploadUserReport}");

          fail(ErrorApiModel.fromDioError(error));
        })
        .catchError((error) {
          fail(ErrorApiModel.identifyError(error: error));
        });
  }
}
