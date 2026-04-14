import 'package:organ_link/apis/models/ministry/ministry_dashboard/monthly_surgery_api_model.dart';
import 'package:organ_link/apis/models/ministry/ministry_dashboard/organ_distribution_api_model.dart';

class MinistryDashboardResponse {
  final int totalPatient;
  final int totalDonor;
  final int totalSurgeries;
  final int totalHospitals;
  final List<OrganDistributionApiModel> organDistribution;
  final List<MonthlySurgeryApiModel> monthlySurgery;

  MinistryDashboardResponse({
    required this.totalPatient,
    required this.totalDonor,
    required this.totalSurgeries,
    required this.totalHospitals,
    required this.organDistribution,
    required this.monthlySurgery,
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
      monthlySurgery: (json["monthly_surgery_stats"] as List)
          .map((x) => MonthlySurgeryApiModel.fromJson(x))
          .toList(),
    );
  }
}
