class ChronicDiseasesApiModel {
  final String name;

  ChronicDiseasesApiModel({required this.name});
  factory ChronicDiseasesApiModel.formJson(Map<String, dynamic> json) {
    return ChronicDiseasesApiModel( name: json["name"] as String);
  }
}
