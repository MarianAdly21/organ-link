import 'package:organ_link/apis/models/user_models/chronic_diseases_api_model.dart';

class UserDataResponse {
  final String fullName;
  final String type;
  final String identificationNumber;
  final String currentState;
  final DateTime age;
  final String medicalFileNumber;
  final String organ;
  final String bloodType;
  // final String upcomingAppointments;
  final List<ChronicDiseasesApiModel> chronicDiseasesList;
  //final List<MedicalTestApiModel> medicalTestList;

  UserDataResponse({
    required this.fullName,
    required this.type,
    required this.identificationNumber,
    required this.currentState, required this.age, required this.medicalFileNumber, required this.organ, required this.bloodType, required this.chronicDiseasesList,
  });
  factory UserDataResponse.formJson(Map<String, dynamic> json) {
    return UserDataResponse(
      fullName: json["full_name"] as String,
      type: json["role"] as String,
      identificationNumber: json["medical_record_number"] as String,
      currentState: json["status"] as String,
      age: DateTime.parse(json["birthdate"]),
      medicalFileNumber: json["medical_record_number"] as String,
      organ: json["organ_needed"] as String,
      bloodType: json["blood_type"] as String,
      // upcomingAppointments: json[""],
      chronicDiseasesList: json["chronic_diseases"] == null
          ? []
          : List<ChronicDiseasesApiModel>.from(
              json["chronic_diseases"]!.map(
                (x) => ChronicDiseasesApiModel.formJson(x),
              ),
            ),
      // medicalTestList: json[""] == null
      //     ? []
      //     : List<MedicalTestApiModel>.from(
      //         json[""]!.map((x) => MedicalTestApiModel.formJson(x)),
      //       ),
    );
  }
}
