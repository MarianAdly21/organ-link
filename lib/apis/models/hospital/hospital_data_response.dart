import 'package:organ_link/apis/models/hospital/matching_api_model.dart';
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
  // final int scheduledSurgeriesCount;
  // final int ongoingSurgeriesCount;
  // final int completedSurgeriesCount;
  // final int underReviewSurgeriesCount;
  final List<MatchingApiModel> matchingList;
  final List<PatientOrDonorApiModel> patientList;
  final List<PatientOrDonorApiModel> donorList;
  //final List surgeriesList;
  final SurgeryApiModel surgeryApiModel;

  HospitalDataResponse({
    required this.hospitalName,
    required this.hospitalCity,
    required this.totalMatches,
    required this.totalSurgeries,
    required this.patientsCount,
    required this.donorsCount,
    required this.matchingList,
    required this.patientList,
    required this.donorList,
   // required this.surgeriesList,
    required this.licenseNumber,
    required this.phone,
    required this.email,
    // required this.scheduledSurgeriesCount,
    // required this.ongoingSurgeriesCount,
    // required this.completedSurgeriesCount,
    // required this.underReviewSurgeriesCount,
    required this.surgeryApiModel,
  });
  factory HospitalDataResponse.formJson(Map<String, dynamic> json) {
    return HospitalDataResponse(
      hospitalName: json["name"],
      hospitalCity: json["location"],
      totalMatches: json["total_matches"],
      totalSurgeries: json["total_surgeries"],
      patientsCount: json["patients_count"],
      donorsCount: json["donors_count"],
      matchingList: (json["matches"] as List? ?? [])
          .map((x) => MatchingApiModel.formJson(x))
          .toList(),
      patientList: (json["patients"] as List? ?? [])
          .map((x) => PatientOrDonorApiModel.formJson(x))
          .toList(),
      donorList: (json["donors"] as List? ?? [])
          .map((x) => PatientOrDonorApiModel.formJson(x))
          .toList(),
     // surgeriesList: json["surgeries"] as List? ?? [],
      licenseNumber: json["license_number"],
      phone: json["phone"],
      email: json["email"],
       surgeryApiModel: SurgeryApiModel.fromJson(json),
    );
  }
}
