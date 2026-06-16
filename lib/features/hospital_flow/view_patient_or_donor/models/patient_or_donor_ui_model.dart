import 'package:organ_link/apis/models/hospital/patient_or_donor_list/patient_or_donor_api_model.dart';
import 'package:organ_link/features/shared_screens/method/calculate_age.dart';

class PatientOrDonorUiModel {
  final String fullName;
  final int age;
  final String role;
  final String bloodType;
  final String organ;
  final String status;
  final String? priority;
  final String medicalRecordNumber;
  final int id;
  final String? healthStatus;

  PatientOrDonorUiModel({
    required this.fullName,
    required this.age,
    required this.bloodType,
    required this.organ,
    required this.status,
    required this.priority,
    required this.id,
    required this.medicalRecordNumber,
    required this.healthStatus,
    required this.role,
  });
  factory PatientOrDonorUiModel.fromApiModel(PatientOrDonorApiModel e) {
    return PatientOrDonorUiModel(
      fullName: e.fullName,
      age: calculateAge(e.age),
      bloodType: e.bloodType,
      organ: e.organ,
      status: e.status,
      // priority: e.priority,
      id: e.id,
      medicalRecordNumber: e.medicalRecordNumber,
      //healthStatus: e.healthStatus,
      priority: e.role == "patient" ? (e.priority ?? "أولوية منخفضة") : null,
      healthStatus: e.role != "patient" ? (e.healthStatus ?? "صحة جيدة") : null,
      role: e.role,
    );
  }
}
