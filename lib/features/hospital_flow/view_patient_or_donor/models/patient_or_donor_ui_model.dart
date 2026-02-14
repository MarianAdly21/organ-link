import 'package:organ_link/apis/models/hospital/patient_or_donor_api_model.dart';

class PatientOrDonorUiModel {
  final String fullName;
  final DateTime age;
  final String bloodType;
  final String organ;
  final String status;
  final String? priority;
  //final String? healthStatus;

  PatientOrDonorUiModel({
    required this.fullName,
    required this.age,
    required this.bloodType,
    required this.organ,
    required this.status,
    required this.priority,
   // required this.healthStatus,
  });
  factory PatientOrDonorUiModel.fromApiModel(PatientOrDonorApiModel e) {
    return PatientOrDonorUiModel(
      fullName: e.fullName,
      age: e.age,
      bloodType: e.bloodType,
      organ: e.organ,
      status: e.status,
      priority: e.priority,
     // healthStatus: e.healthStatus,
    );
  }
}
