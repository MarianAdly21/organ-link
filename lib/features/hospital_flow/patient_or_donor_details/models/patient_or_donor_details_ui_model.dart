import 'package:organ_link/apis/models/hospital/patient_or_donor_details_api_model.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/models/allergies_ui_model.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/models/current_medications_ui_model.dart';
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
  final List<AllergiesUiModel> allergiesList;
  final List<CurrentMedicationsUiModel> currentMedicationsList;
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
    required this.allergiesList,
    required this.currentMedicationsList,
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
      allergiesList: e.allergies
          .map((x) => AllergiesUiModel.fromApiModel(x))
          .toList(),
      currentMedicationsList: e.currentMedicationsList
          .map((x) => CurrentMedicationsUiModel.fromApiModel(x))
          .toList(),
      reportAndInvestigations: e.reportAndInvestigations
          .map((x) => MedicalTestUiModel.fromApiModel(x))
          .toList(),
    );
  }
}
