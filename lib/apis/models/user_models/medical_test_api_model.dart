class MedicalTestApiModel {
  final String testName;
  final String status;
  final DateTime date;

  MedicalTestApiModel({
    required this.testName,
    required this.status,
    required this.date,
  });
  factory MedicalTestApiModel.formJson(Map<String, dynamic> json) {
    return MedicalTestApiModel(
      testName: json["report_type"],
      status: json["state"],
      date: DateTime.parse(json["created_at"]),
    );
  }
}
