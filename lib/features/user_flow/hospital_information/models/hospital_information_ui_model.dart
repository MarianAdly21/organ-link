import 'package:organ_link/apis/models/user_models/user_data_response.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/hospital_details_ui_model.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/supervisor_doctor_ui_model.dart';

class HospitalInformationUiModel {
  final HospitalDetailsUiModel hospitalUiModel;
  final SupervisorDoctorUiModel supervisorDoctorUiModel;

  HospitalInformationUiModel({
    required this.hospitalUiModel,
    required this.supervisorDoctorUiModel,
  });
  factory HospitalInformationUiModel.fromApiModel(UserDataResponse e) {
    return HospitalInformationUiModel(
      hospitalUiModel: HospitalDetailsUiModel.fromApiModel(e.hospitalDetails),
      supervisorDoctorUiModel: SupervisorDoctorUiModel.fromApiModel(
       e.supervisorDoctorDetails,
      ),
    );
  }
}
