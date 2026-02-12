import 'package:organ_link/apis/models/user_models/chronic_diseases_api_model.dart';
import 'package:organ_link/apis/models/user_models/hospital_api_details.dart';
import 'package:organ_link/apis/models/user_models/supervisor_doctor_api_details.dart';

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
  final HospitalApiDetails hospitalDetails;
  final SupervisorDoctorApiDetails supervisorDoctorDetails;

  UserDataResponse({
    required this.fullName,
    required this.type,
    required this.identificationNumber,
    required this.currentState,
    required this.age,
    required this.medicalFileNumber,
    required this.organ,
    required this.bloodType,
    required this.chronicDiseasesList,
    required this.hospitalDetails,
    required this.supervisorDoctorDetails,
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
      hospitalDetails: HospitalApiDetails.formJson(
        json["hospital_detail"] as Map<String, dynamic>,
      ),
      supervisorDoctorDetails: SupervisorDoctorApiDetails.formJson(
        json["supervisor_doctor_detail"] as Map<String, dynamic>,
      ),
    );
  }
}

