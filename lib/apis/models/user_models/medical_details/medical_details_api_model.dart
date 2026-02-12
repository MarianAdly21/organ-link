import 'package:organ_link/apis/models/user_models/medical_details/chronic_diseases_api_model.dart';

class MedicalDetailsApiModel {
  final String fullName;
  final String type;
  final DateTime age;
  final String medicalFileNumber;
  final String organ;
  final String bloodType;
  // final String upcomingAppointments;
  final List<ChronicDiseasesApiModel> chronicDiseasesList;
  //final List<MedicalTestApiModel> medicalTestList;

  MedicalDetailsApiModel({
    required this.fullName,
    required this.type,
    required this.age,
    required this.medicalFileNumber,
    required this.organ,
    required this.bloodType,
    //required this.upcomingAppointments,
    required this.chronicDiseasesList,
    // required this.medicalTestList,
  });

  factory MedicalDetailsApiModel.formJson(Map<String, dynamic> json) {
    return MedicalDetailsApiModel(
      fullName: json["full_name"] as String,
      type: json["role"] as String,
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
