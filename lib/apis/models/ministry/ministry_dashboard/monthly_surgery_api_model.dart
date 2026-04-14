class MonthlySurgeryApiModel {
  final String month;
  final int totalSurgeries;
  final int successfulSurgeries;

  MonthlySurgeryApiModel({
    required this.month,
    required this.totalSurgeries,
    required this.successfulSurgeries,
  });
  factory MonthlySurgeryApiModel.fromJson(Map<String, dynamic> json) {
    return MonthlySurgeryApiModel(
      month: json["month"] as String,
      totalSurgeries: json["total_surgeries"] as int,
      successfulSurgeries: json["successful_surgeries"] as int,
    );
  }
}
