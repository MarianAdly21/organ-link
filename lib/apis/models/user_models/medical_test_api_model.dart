class MedicalTestApiModel {
  final String testName;
  final String status;
  final String testType;

  final DateTime date;

  MedicalTestApiModel({
    required this.testName,
    required this.status,
    required this.date,
    required this.testType,
  });
  factory MedicalTestApiModel.formJson(Map<String, dynamic> json) {
    return MedicalTestApiModel(
      testName: json["description"],
      status: json["state"],
      date: DateTime.parse(json["created_at"]),
      testType: json["report_type"],
    );
  }
}
