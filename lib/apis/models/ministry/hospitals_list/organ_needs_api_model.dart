
class OrganNeedsApiModel {
  final String organName;
  final int organCount;

  OrganNeedsApiModel({required this.organName, required this.organCount});
  factory OrganNeedsApiModel.fromJson(Map<String, dynamic> json) {
    return OrganNeedsApiModel(
      organName: json["organ"],
      organCount: json["count"],
    );
  }
}
