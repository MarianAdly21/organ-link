import 'package:organ_link/apis/models/user_models/medical_test_api_model.dart';

class MedicalTestUiModel {
  final String testName;
  final String status;
  final String testType;
  final DateTime date;

  MedicalTestUiModel({
    required this.testName,
    required this.status,
    required this.date,
    required this.testType,
  });

  factory MedicalTestUiModel.fromApiModel(MedicalTestApiModel e) {
    return MedicalTestUiModel(
      testName: e.testName,
      status: e.status,
      date: e.date,
      testType: e.testType,
    );
  }
}
