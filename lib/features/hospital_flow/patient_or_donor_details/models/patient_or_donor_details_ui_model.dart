import 'package:organ_link/apis/models/hospital/patient_or_donor_details_api_model.dart';
import 'package:organ_link/features/shared_screens/method/calculate_age.dart';
import 'package:organ_link/features/user_flow/medical_details/models/medical_test_ui_model.dart';

class PatientOrDonorDetailsUiModel {
  final String fullName;
  final String fileNumber;
  final String status;
  final String priority;
  // final String healthyStatus;
  final int age;
  final String gender;
  final String bloodType;
  final String phoneNumber;
  final String email;
  final String city;
  final String role;
  final String organ;
  final List<String> medicalHistory;
  final List<String> allergies;
  final List<String> currentMedications;
  // final List<String> vitalSigns;
  final List<MedicalTestUiModel> reportAndInvestigations;

  PatientOrDonorDetailsUiModel({
    required this.fullName,
    required this.fileNumber,
    required this.status,
    required this.priority,
    required this.age,
    required this.gender,
    required this.bloodType,
    required this.phoneNumber,
    required this.email,
    required this.city,
    required this.role,
    required this.organ,
    required this.medicalHistory,
    required this.allergies,
    required this.currentMedications,
    required this.reportAndInvestigations,
  });
  factory PatientOrDonorDetailsUiModel.fromApiModel(
    PatientOrDonorDetailsApiModel e,
  ) {
    return PatientOrDonorDetailsUiModel(
      fullName: e.fullName,
      fileNumber: e.fileNumber,
      status: e.status,
      priority: e.priority,
      age: calculateAge(e.age),
      gender: e.gender,
      bloodType: e.bloodType,
      phoneNumber: e.phoneNumber,
      email: e.email,
      city: e.city,
      role: e.role,
      organ: e.organ,
      medicalHistory: e.medicalHistory,
      allergies: e.allergies,
      currentMedications: e.currentMedications,
      reportAndInvestigations: e.reportAndInvestigations
          .map((x) => MedicalTestUiModel.fromApiModel(x))
          .toList(),
    );
  }
}
