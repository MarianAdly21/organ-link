class ChronicDiseasesApiModel {
  final String name;

  ChronicDiseasesApiModel({required this.name});
  factory ChronicDiseasesApiModel.fromJson(Map<String, dynamic> json) {
    return ChronicDiseasesApiModel( name: json["name"] as String);
  }
}
