
class MedicalTestApiModel {
  final String testName;
  final DateTime date;
  final String  testStatus ;
  final String testResult;

  MedicalTestApiModel({required this.testName, required this.date, required this.testStatus, required this.testResult});
  factory MedicalTestApiModel.fromJson(Map<String,dynamic>json)
  {
    return MedicalTestApiModel(testName: json["testName"], date: json["date"], testStatus: json["testStatus"], testResult: json["testResult"]);
  }

}
