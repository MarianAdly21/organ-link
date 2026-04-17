import 'package:organ_link/apis/models/shared_models/chronic_diseases_api_model.dart';
import 'package:organ_link/apis/models/shared_models/medical_test_api_model.dart';

class MedicalDetailsApiModel {
  final String fullName;
  final String type;
  final String organ;
  final String medicalFileNumber;
  final DateTime age;
  final String bloodType;
  final DateTime? upcomingAppointments;
  final List<ChronicDiseasesApiModel> chronicDiseasesList;
  final List<MedicalTestApiModel> medicalTestList;

  MedicalDetailsApiModel({
    required this.fullName,
    required this.type,
    required this.organ,
    required this.medicalFileNumber,
    required this.age,
    required this.bloodType,
    required this.upcomingAppointments,
    required this.chronicDiseasesList,
    required this.medicalTestList,
  });
  factory MedicalDetailsApiModel.formJson(Map<String, dynamic> json) {
    DateTime? lastAppointmentDate;
    if (json["appointments"] != null &&
        (json["appointments"] as List).isNotEmpty) {
      final appointments = json["appointments"] as List;
      final lastAppointment = appointments.last;
      lastAppointmentDate = DateTime.parse(
        lastAppointment["appointment_date"],
      ).toLocal();
    }
    return MedicalDetailsApiModel(
      fullName: json["full_name"] as String,
      type: json["role"] as String,
      medicalFileNumber: json["medical_record_number"] as String,
      age: DateTime.parse(json["birthdate"]),
      organ: json["organ_needed"] as String,
      bloodType: json["blood_type"] as String,
      upcomingAppointments: lastAppointmentDate,
      chronicDiseasesList: (json["chronic_diseases"] as List? ?? [])
          .map((x) => ChronicDiseasesApiModel.fromJson(x))
          .toList(),
      medicalTestList: (json["user_reports"] as List? ?? [])
          .map((x) => MedicalTestApiModel.formJson(x))
          .toList(),
    );
  }
}
