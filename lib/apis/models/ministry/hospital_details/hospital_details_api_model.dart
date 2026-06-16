import 'package:organ_link/apis/models/ministry/hospital_details/last_surgeries_api_model.dart';
import 'package:organ_link/apis/models/ministry/hospitals_list/organ_needs_api_model.dart';

class HospitalDetailsApiModel {
  final String hospitalName;
  final String hospitalLocation;
  final String hospitalStatus;
  final String hospitalType;
  final String phone;
  final String email;
  final int totalPatients;
  final int totalDonors;
  final int totalSurgeries;
  final double successPercentage;
  final List<OrganNeedsApiModel> organNeeds;
  final List<LastSurgeriesApiModel> lastSurgeries;

  HospitalDetailsApiModel({
    required this.hospitalName,
    required this.hospitalLocation,
    required this.hospitalStatus,
    required this.hospitalType,
    required this.phone,
    required this.email,
    required this.totalPatients,
    required this.totalDonors,
    required this.totalSurgeries,
    required this.successPercentage,
    required this.organNeeds,
    required this.lastSurgeries,
  });

  factory HospitalDetailsApiModel.fromJson(Map<String, dynamic> json) {
    return HospitalDetailsApiModel(
      hospitalName: json["name"],
      hospitalLocation: json["location"],
      hospitalStatus: json["status"],
      hospitalType: json["hospital_type"],
      phone: json["phone"],
      email: json["email"],
      totalPatients: json["patients_count"],
      totalDonors: json["donors_count"],
      totalSurgeries: json["successful_surgeries"],
      successPercentage:( json["success_percentage"]as num).toDouble(),
      organNeeds: (json["organs_needed"] as List)
          .map((x) => OrganNeedsApiModel.fromJson(x))
          .toList(),
      lastSurgeries: (json["latest_successful_surgeries"] as List? ?? [])
          .map((x) => LastSurgeriesApiModel.fromJson(x))
          .toList(),
    );
  }
}
