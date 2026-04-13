import 'package:organ_link/apis/models/ministry/ministry_dashboard/organ_distribution_api_model.dart';

class OrganDistributionUiModel {
  final String organ;
  final double percentage;

  OrganDistributionUiModel({required this.organ, required this.percentage});
  factory OrganDistributionUiModel.fromApiModel(OrganDistributionApiModel e) {
    return OrganDistributionUiModel(organ: e.organ, percentage: e.percentage);
  }
}
