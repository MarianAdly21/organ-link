import 'package:organ_link/apis/models/hospital/matching_api_model.dart';

class HospitalDataResponse {
  final String hospitalName;
  final String hospitalCity;
  final int totalMatches;
  final int totalSurgeries;
  final int patientsCount;
  final int donorsCount;
  final List<MatchingApiModel> matchingList;

  HospitalDataResponse({
    required this.hospitalName,
    required this.hospitalCity,
    required this.totalMatches,
    required this.totalSurgeries,
    required this.patientsCount,
    required this.donorsCount,
    required this.matchingList,
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
    );
  }
}
