import 'package:organ_link/apis/models/hospital/surgery_list_api_model.dart';

class SurgeryListUiModel {
  final String surgeryName;
  final String surgeryNumber;
  final String patientName;
  final String donorName;
  final String department;
  final String date;
  final String surgeryState;
  final int id;
  final int duration;

  SurgeryListUiModel({
    required this.surgeryName,
    required this.surgeryNumber,
    required this.surgeryState,
    required this.patientName,
    required this.donorName,
    required this.department,
    required this.date,
    required this.id,
    required this.duration,
  });

  factory SurgeryListUiModel.fromApiModel(SurgeryListApiModel e) {
    return SurgeryListUiModel(
      surgeryName: e.surgeryName,
      surgeryNumber: e.surgeryNumber,
      patientName: e.patientName,
      donorName: e.donorName,
      department: e.department,
      date: e.date,
      surgeryState: e.surgeryState,
      id: e.id,
      duration: e.duration,
    );
  }
}
