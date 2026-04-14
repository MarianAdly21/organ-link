import 'package:organ_link/apis/models/ministry/hospitals_list/organ_needs_api_model.dart';

class HospitalApiModel {
  final String hospitalName;
  final int hospitalId;
  final String hospitalLocation;
  final String hospitalStatus;
  final int surgeriesCount;
  final int donorsCount;
  final int patientsCount;
  final List<OrganNeedsApiModel> organNeeds;

  HospitalApiModel({
    required this.hospitalName,
    required this.hospitalLocation,
    required this.hospitalStatus,
    required this.surgeriesCount,
    required this.donorsCount,
    required this.patientsCount,
    required this.organNeeds,
    required this.hospitalId,
  });
  factory HospitalApiModel.fromJson(Map<String, dynamic> json) {
    return HospitalApiModel(
      hospitalName: json["name"] as String,
      hospitalId: json["id"] as int,
      hospitalLocation: json["location"] as String,
      hospitalStatus: json["status"] as String,
      surgeriesCount: json["total_surgeries"] as int,
      donorsCount: json["donors_count"] as int,
      patientsCount: json["patients_count"] as int,
      organNeeds: (json["organs_needed"] as List)
          .map((x) => OrganNeedsApiModel.fromJson(x))
          .toList(),
    );
  }
}
