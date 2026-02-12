import 'package:organ_link/apis/models/user_models/hospital_api_details.dart';

class HospitalDetailsUiModel {
  final String hospitalName;
  final String city;
  final String location;
  final String emergencyPhone;
  final String minaPhone;
  final String email;
  final String workingHours;

  HospitalDetailsUiModel({
    required this.hospitalName,
    required this.city,
    required this.location,
    required this.emergencyPhone,
    required this.minaPhone,
    required this.email,
    required this.workingHours,
  });
  factory HospitalDetailsUiModel.fromApiModel(HospitalApiDetails e) {
    return HospitalDetailsUiModel(
      hospitalName: e.hospitalName,
      city: e.city,
      location: e.location,
      emergencyPhone: e.emergencyPhone,
      minaPhone: e.minaPhone,
      email: e.email,
      workingHours: e.workingHours,
    );
  }
}
