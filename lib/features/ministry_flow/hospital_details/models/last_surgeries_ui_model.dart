import 'package:organ_link/apis/models/ministry/hospital_details/last_surgeries_api_model.dart';

class LastSurgeriesUiModel {
  final String organ;
  final String surgeryStatus;
  final DateTime age;
  final DateTime date;

  LastSurgeriesUiModel({
    required this.organ,
    required this.surgeryStatus,
    required this.age,
    required this.date,
  });
  factory LastSurgeriesUiModel.fromApiModel(LastSurgeriesApiModel e) {
    return LastSurgeriesUiModel(
      organ: e.organ,
      surgeryStatus: e.surgeryStatus,
      age: e.age,
      date: e.date,
    );
  }
}
