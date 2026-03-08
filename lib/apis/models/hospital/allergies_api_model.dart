class AllergiesApiModel {
  final String name;

  AllergiesApiModel({required this.name});
  factory AllergiesApiModel.fromJson(Map<String, dynamic> json) {
    return AllergiesApiModel(name: json["name"]);
  }
}