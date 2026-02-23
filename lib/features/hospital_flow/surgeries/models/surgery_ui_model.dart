import 'package:organ_link/apis/models/hospital/surgery_api_model.dart';

class SurgeryUiModel {
  final String surgeryName;
  final String surgeryNumber;
  final String patientName;
  final String donorName;
  final String department;
  final String date;
  final String surgeryState;
final int id;

  SurgeryUiModel({
    required this.surgeryName,
    required this.surgeryNumber,
    required this.surgeryState,
    required this.patientName,
    required this.donorName,
    required this.department,
    required this.date,
    required this.id,
  });

  factory SurgeryUiModel.fromApiModel(SurgeryApiModel e) {
    return SurgeryUiModel(
      surgeryName: e.surgeryName,
      surgeryNumber: e.surgeryNumber,
      patientName: e.patientName,
      donorName: e.donorName,
      department: e.department,
      date: e.date,
      surgeryState: e.surgeryState,
      id: e.id
    );
  }
}
