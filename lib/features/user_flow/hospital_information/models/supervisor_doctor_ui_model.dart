import 'package:organ_link/apis/models/user_models/supervisor_doctor_api_details.dart';

class SupervisorDoctorUiModel {
  final String doctorName;
  final String specialty;
  final String phone;

  SupervisorDoctorUiModel({
    required this.doctorName,
    required this.specialty,
    required this.phone,
  });
  factory SupervisorDoctorUiModel.fromApiModel(SupervisorDoctorApiDetails e) {
    return SupervisorDoctorUiModel(
      doctorName: e.doctorName,
      specialty: e.specialty,
      phone: e.phone,
    );
  }
}
