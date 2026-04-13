class OrganDistributionApiModel {
  final String organ;
  final double percentage;

  OrganDistributionApiModel({required this.organ, required this.percentage});

  factory OrganDistributionApiModel.fromJson(Map<String, dynamic> json) {
    return OrganDistributionApiModel(
      organ: json["organ"] as String,
      percentage: json["percentage"] as double,
    );
  }
}
