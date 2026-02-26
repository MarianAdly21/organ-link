import 'package:organ_link/apis/models/user_models/medical_test_api_model.dart';

class PatientOrDonorDetailsApiModel {
  final String fullName;
  final String fileNumber;
  final String status;
  final String priority;
  // final String healthyStatus;
  final DateTime age;
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
  final List<MedicalTestApiModel> reportAndInvestigations;

  PatientOrDonorDetailsApiModel({
    required this.fullName,
    required this.fileNumber,
    required this.status,
    required this.priority,
    // required this.healthyStatus,
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
  factory PatientOrDonorDetailsApiModel.formJson(Map<String, dynamic> json) {
    return PatientOrDonorDetailsApiModel(
      fullName: json["full_name"],
      fileNumber: json["medical_record_number"],
      status: json["status"],
      priority: "أولوية عالية",
      //json[""],
      // healthyStatus: json[""],
      age: DateTime.parse(json["birthdate"]),
      gender: json["gender"],
      bloodType: json["blood_type"],
      phoneNumber: "0111964378",
      //json[""],
      email: "user@gamil.com",
      //json[""],
      city: "العاشر من رمضان",
      //json[""],
      role: json["role"],
      organ: json["organ_needed"] ?? json["organ_available"],
      medicalHistory: medicalHistoryDemoList,
      allergies: allergiesDemoList,
      currentMedications: currentMedicationsDemoList,
      reportAndInvestigations: (json["user_reports"] as List? ?? [])
          .map((x) => MedicalTestApiModel.formJson(x))
          .toList(),
    );
  }
}

List<String> medicalHistoryDemoList = [
  "السكري من النوع الثاني",
  "ارتفاع ضغط الدم",
  "فشل كلوي مزمن",
];
List<String> allergiesDemoList = [" البنسلين"];
List<String> currentMedicationsDemoList = [
  "إنسولين: 3 مرات يومياً",
  "أدوية الضغط - مرة واحدة يومياً",
];
