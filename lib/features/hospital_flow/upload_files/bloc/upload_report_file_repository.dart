import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/apis/models/hospital/upload_file/upload_file_send_api_model.dart';
import 'package:organ_link/features/hospital_flow/upload_files/bloc/upload_report_file_bloc.dart';
import 'package:organ_link/features/hospital_flow/upload_files/model/upload_file_response_ui.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseUploadReportFileRepository {
  Future<UploadReportFileState> uploadReport(
    UploadFileSendApiModel uploadFileSendApiModel,
  );
}

class UploadReportFileRepository implements BaseUploadReportFileRepository {
  final HospitalApiManager hospitalApiManager;
  final PreferencesManager preferencesManager;

  UploadReportFileRepository({
    required this.hospitalApiManager,
    required this.preferencesManager,
  });
  @override
  Future<UploadReportFileState> uploadReport(
    UploadFileSendApiModel uploadFileSendApiModel,
  ) async {
    late UploadReportFileState uploadReportFileState;
    final String? token = await preferencesManager.getToken();
    await hospitalApiManager.uploadReportApi(
      uploadFileSendApiModel,
      token!,
      (response) {
        final model = UploadFileResponseUi.fromApiModel(response);
        uploadReportFileState = UploadReportFileSuccessfullyState(
          uploadFileResponseUi: model,
        );
      },
      (error) {
        uploadReportFileState = UploadReportFileErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return uploadReportFileState;
  }
}
