import 'package:organ_link/apis/models/user_models/supervisor_doctor_api_details.dart';

class HospitalInformationUserApiModel {
  final String hospitalName;
  final String city;
  final String location;
  final String emergencyPhone;
  final String minaPhone;
  final String email;
  final String workingHours;
  final SupervisorDoctorApiDetails supervisorDoctorDetails;

  HospitalInformationUserApiModel({
    required this.hospitalName,
    required this.city,
    required this.location,
    required this.emergencyPhone,
    required this.minaPhone,
    required this.email,
    required this.workingHours,
    required this.supervisorDoctorDetails,
  });
  factory HospitalInformationUserApiModel.formJson(Map<String, dynamic> json) {
    return HospitalInformationUserApiModel(
      hospitalName: json["hospital_detail"]["name"],
      city: json["hospital_detail"]["city"],
      location: json["hospital_detail"]["location"],
      emergencyPhone: json["hospital_detail"]["emergency_phone"],
      minaPhone: json["hospital_detail"]["phone"],
      email: json["hospital_detail"]["email"],
      workingHours: json["hospital_detail"]["working_hours"],
      supervisorDoctorDetails: SupervisorDoctorApiDetails.formJson(
        json["supervisor_doctors_detail"] as Map<String, dynamic>,
      ),
    );
  }
}
