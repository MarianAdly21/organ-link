import 'package:organ_link/apis/models/user_models/user_data_response.dart';
import 'package:organ_link/features/user_flow/medical_details/models/chronic_diseases_ui_model.dart';
import 'package:organ_link/features/user_flow/medical_details/models/medical_test_ui_model.dart';

class MedicalDetailsUiModel {
  final String fullName;
  final String type;
  final DateTime age;
  final String medicalFileNumber;
  final String organ;
  final String bloodType;
  final String upcomingAppointments;
  final List<ChronicDiseasesUiModel> chronicDiseasesList;
  final List<MedicalTestUiModel> medicalTestList;

  MedicalDetailsUiModel({
    required this.fullName,
    required this.type,
    required this.age,
    required this.medicalFileNumber,
    required this.organ,
    required this.bloodType,
    required this.chronicDiseasesList,
    required this.medicalTestList,
    required this.upcomingAppointments,
  });

  factory MedicalDetailsUiModel.fromApiModel(UserDataResponse e) {
    return MedicalDetailsUiModel(
      fullName: e.fullName,
      type: e.type,
      age: e.age,
      medicalFileNumber: e.medicalFileNumber,
      organ: e.organ,
      bloodType: e.bloodType,
      chronicDiseasesList: e.chronicDiseasesList
          .map((e) => ChronicDiseasesUiModel.fromApiModel(e))
          .toList(),
      medicalTestList:[],
      //  e.medicalTestList
      //     .map((e) => MedicalTestUiModel.fromApiModel(e))
      //     .toList(),
      upcomingAppointments: "25 نوفمبر 2025",
    );
  }
}
