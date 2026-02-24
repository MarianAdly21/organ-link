import 'package:organ_link/apis/models/hospital/surger_details_api_model.dart';

class SurgeryDetailsUiModel {
  final String surgeryNumber;
  final String organType;
  final String responsibleSurgeon;
  final String department;
  final String? date;
  final String surgeryStatus;
  final String patientName;
  final int patientId;
  final String patientFileNumber;
  final String donorName;
  final int donorId;
  final String donorNameFileNumber;

  SurgeryDetailsUiModel({
    required this.surgeryNumber,
    required this.organType,
    required this.responsibleSurgeon,
    required this.department,
    required this.date,
    required this.surgeryStatus,
    required this.patientName,
    required this.patientFileNumber,
    required this.donorName,
    required this.donorNameFileNumber,
    required this.patientId,
    required this.donorId,
  });
  factory SurgeryDetailsUiModel.fromApiModel(SurgerDetailsApiModel e) {
    return SurgeryDetailsUiModel(
      surgeryNumber: e.surgeryNumber,
      organType: e.organType,
      responsibleSurgeon: e.responsibleSurgeon,
      department: e.department,
      date: e.date,
      surgeryStatus: e.surgeryStatus,
      patientName: e.patientName,
      patientFileNumber: e.patientFileNumber,
      donorName: e.donorName,
      donorNameFileNumber: e.donorNameFileNumber,
      patientId: e.patientId,
      donorId: e.donorId,
    );
  }
}
