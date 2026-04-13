import 'package:organ_link/apis/models/ministry/ministry_dashboard/organ_distribution_api_model.dart';

class MinistryDashboardResponse {
  final int totalPatient;
  final int totalDonor;
  final int totalSurgeries;
  final int totalHospitals;
  final List<OrganDistributionApiModel> organDistribution;

  MinistryDashboardResponse({
    required this.totalPatient,
    required this.totalDonor,
    required this.totalSurgeries,
    required this.totalHospitals,
    required this.organDistribution,
  });

  factory MinistryDashboardResponse.fromJson(Map<String, dynamic> json) {
    return MinistryDashboardResponse(
      totalPatient: json["total_patients"] as int,
      totalDonor: json["total_donors"] as int,
      totalSurgeries: json["total_surgeries"] as int,
      totalHospitals: json["total_hospitals"] as int,
      organDistribution: (json["organs_stats"] as List)
          .map((x) => OrganDistributionApiModel.fromJson(x))
          .toList(),
    );
  }
}
