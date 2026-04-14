class LastSurgeriesApiModel {
  final String organ;
  final String surgeryStatus;
  final DateTime age;
  final DateTime date;

  LastSurgeriesApiModel({
    required this.organ,
    required this.surgeryStatus,
    required this.age,
    required this.date,
  });
  factory LastSurgeriesApiModel.fromJson(Map<String, dynamic> json) {
    return LastSurgeriesApiModel(
      organ: json["organ_type"],
      surgeryStatus: json["status"],
      age: DateTime.parse(json["birthdate"]),
      date: DateTime.parse(json["created_at"]),
    );
  }
}
