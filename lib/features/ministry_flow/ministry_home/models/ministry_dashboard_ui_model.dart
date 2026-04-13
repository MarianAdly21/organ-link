import 'package:organ_link/apis/models/ministry/ministry_dashboard/ministry_dashboard_response.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/organ_distribution_ui_model.dart';

class MinistryDashboardUiModel {
  final int totalPatient;
  final int totalDonor;
  final int totalSurgeries;
  final int totalHospitals;
  final List<OrganDistributionUiModel> organDistribution;

  MinistryDashboardUiModel({
    required this.totalPatient,
    required this.totalDonor,
    required this.totalSurgeries,
    required this.totalHospitals,
    required this.organDistribution,
  });

  factory MinistryDashboardUiModel.fromApiModel(MinistryDashboardResponse e) {
    return MinistryDashboardUiModel(
      totalPatient: e.totalPatient,
      totalDonor: e.totalDonor,
      totalSurgeries: e.totalSurgeries,
      totalHospitals: e.totalHospitals,
      organDistribution: e.organDistribution
          .map((e) => OrganDistributionUiModel.fromApiModel(e))
          .toList(),
    );
  }
}
