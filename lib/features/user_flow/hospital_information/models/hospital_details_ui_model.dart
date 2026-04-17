import 'package:organ_link/apis/models/user_models/hospital_information_user_api_model.dart';
import 'package:organ_link/features/user_flow/hospital_information/models/supervisor_doctor_ui_model.dart';

class HospitalDetailsUiModel {
  final String hospitalName;
  final String city;
  final String location;
  final String emergencyPhone;
  final String minaPhone;
  final String email;
  final String workingHours;
  final SupervisorDoctorUiModel supervisorDoctorDetails;

  HospitalDetailsUiModel({
    required this.hospitalName,
    required this.city,
    required this.location,
    required this.emergencyPhone,
    required this.minaPhone,
    required this.email,
    required this.workingHours,
    required this.supervisorDoctorDetails,
  });
  factory HospitalDetailsUiModel.fromApiModel(
    HospitalInformationUserApiModel e,
  ) {
    return HospitalDetailsUiModel(
      hospitalName: e.hospitalName,
      city: e.city,
      location: e.location,
      emergencyPhone: e.emergencyPhone,
      minaPhone: e.minaPhone,
      email: e.email,
      workingHours: e.workingHours,
      supervisorDoctorDetails: SupervisorDoctorUiModel.fromApiModel(
        e.supervisorDoctorDetails,
      ),
    );
  }
}
