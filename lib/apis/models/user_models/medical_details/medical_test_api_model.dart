class MedicalTestApiModel {
  final String testName;
  final String status;
  final String date;

  MedicalTestApiModel({
    required this.testName,
    required this.status,
    required this.date,
  });
  factory MedicalTestApiModel.formJson(Map<String, dynamic> json) {
    return MedicalTestApiModel(
      testName: json[""],
      status: json[""],
      date: json[""],
    );
  }
}
