import 'package:organ_link/apis/models/user_models/medical_details/medical_test_api_model.dart';

class MedicalTestUiModel {
  final String testName;
  final String status;
  final String date;

  MedicalTestUiModel({
    required this.testName,
    required this.status,
    required this.date,
  });

  factory MedicalTestUiModel.fromApiModel(MedicalTestApiModel e) {
    return MedicalTestUiModel(
      testName: e.testName,
      status: e.status,
      date: e.date,
    );
  }
}
