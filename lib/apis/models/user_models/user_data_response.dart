import 'package:organ_link/apis/models/user_models/chronic_diseases_api_model.dart';
import 'package:organ_link/apis/models/user_models/hospital_api_details.dart';
import 'package:organ_link/apis/models/user_models/medical_test_api_model.dart';
import 'package:organ_link/apis/models/user_models/notification_user_api_model.dart';
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
  final DateTime? upcomingAppointments;
  final List<ChronicDiseasesApiModel> chronicDiseasesList;
  final List<MedicalTestApiModel> medicalTestList;
  final HospitalApiDetails hospitalDetails;
 // final SupervisorDoctorApiDetails supervisorDoctorDetails;
  final List<NotificationUserApiModel> notificationList;

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
  //  required this.supervisorDoctorDetails,
    required this.upcomingAppointments,
    required this.medicalTestList,
    required this.notificationList,
  });
  factory UserDataResponse.formJson(Map<String, dynamic> json) {
    DateTime? lastAppointmentDate;
    if (json["appointments"] != null &&
        (json["appointments"] as List).isNotEmpty) {
      final appointments = json["appointments"] as List;
      final lastAppointment = appointments.last;
      lastAppointmentDate = DateTime.parse(
        lastAppointment["appointment_date"],
      ).toLocal();
    }
    return UserDataResponse(
      fullName: json["full_name"] as String,
      type: json["role"] as String,
      identificationNumber: json["medical_record_number"] as String,
      currentState: json["status"] as String,
      age: DateTime.parse(json["birthdate"]),
      medicalFileNumber: json["medical_record_number"] as String,
      organ: json["organ_needed"] as String,
      bloodType: json["blood_type"] as String,
      upcomingAppointments: lastAppointmentDate,
      chronicDiseasesList: (json["chronic_diseases"] as List? ?? [])
          .map((x) => ChronicDiseasesApiModel.formJson(x))
          .toList(),
      medicalTestList:  (json["user_reports"] as List? ?? [])
          .map((x) => MedicalTestApiModel.formJson(x))
          .toList(),
      hospitalDetails: HospitalApiDetails.formJson(
        json["hospital_detail"] as Map<String, dynamic>,
      ),
      // supervisorDoctorDetails: SupervisorDoctorApiDetails.formJson(
      //   json["supervisor_doctor_detail"] as Map<String, dynamic>,
      // ),
      notificationList: (json["alerts"] as List? ?? [])
          .map((x) => NotificationUserApiModel.formJson(x))
          .toList(),
    );
  }
}
