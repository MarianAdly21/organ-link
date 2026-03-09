import 'package:organ_link/apis/models/hospital/hospital_notification_api_model.dart';
import 'package:organ_link/apis/models/hospital/match_api_model.dart';
import 'package:organ_link/apis/models/hospital/patient_or_donor_api_model.dart';
import 'package:organ_link/apis/models/hospital/surgery_api_model.dart';

class HospitalDataResponse {
  final String hospitalName;
  final String hospitalCity;
  final String licenseNumber;
  final String phone;
  final String email;
  final int totalMatches;
  final int totalSurgeries;
  final int patientsCount;
  final int donorsCount;
  final List<PatientOrDonorApiModel> patientList;
  final List<PatientOrDonorApiModel> donorList;
  final SurgeryApiModel surgeryApiModel;
  final MatchApiModel matchApiModel;
  final HospitalNotificationApiModel hospitalNotificationApiModel;

  HospitalDataResponse({
    required this.hospitalName,
    required this.hospitalCity,
    required this.totalMatches,
    required this.totalSurgeries,
    required this.patientsCount,
    required this.donorsCount,
    required this.matchApiModel,
    required this.patientList,
    required this.donorList,
    required this.licenseNumber,
    required this.phone,
    required this.email,
    required this.surgeryApiModel,
    required this.hospitalNotificationApiModel,
  });
  factory HospitalDataResponse.formJson(Map<String, dynamic> json) {
    return HospitalDataResponse(
      hospitalName: json["name"],
      hospitalCity: json["location"],
      totalMatches: json["total_matches"],
      totalSurgeries: json["total_surgeries"],
      patientsCount: json["patients_count"],
      donorsCount: json["donors_count"],
      patientList: (json["patients"] as List? ?? [])
          .map((x) => PatientOrDonorApiModel.formJson(x))
          .toList(),
      donorList: (json["donors"] as List? ?? [])
          .map((x) => PatientOrDonorApiModel.formJson(x))
          .toList(),
      licenseNumber: json["license_number"],
      phone: json["phone"],
      email: json["email"],
      surgeryApiModel: SurgeryApiModel.fromJson(json),
      matchApiModel: MatchApiModel.fromJson(json),
      hospitalNotificationApiModel: HospitalNotificationApiModel.fromJson(json),
    );
  }
}
