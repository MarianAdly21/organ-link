import 'package:organ_link/apis/models/ministry/ministry_dashboard/monthly_surgery_api_model.dart';

class MonthlySurgeryUiModel {
  final String month;
  final int totalSurgeries;
  final int successfulSurgeries;

  MonthlySurgeryUiModel({
    required this.month,
    required this.totalSurgeries,
    required this.successfulSurgeries,
  });
  factory MonthlySurgeryUiModel.fromApiModel(MonthlySurgeryApiModel e) {
    return MonthlySurgeryUiModel(
      month: e.month,
      totalSurgeries: e.totalSurgeries,
      successfulSurgeries: e.successfulSurgeries,
    );
  }
}
