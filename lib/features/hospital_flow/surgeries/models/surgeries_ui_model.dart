import 'package:organ_link/features/hospital_flow/enum/operation_status.dart';

class SurgeryUiModel {
  final String surgeryName;
  final String surgeryNumber;
  final String patientName;
  final String donorName;
  final String hospitalName;
  final String date;
  final String surgeryState;

  SurgeryUiModel({
    required this.surgeryName,
    required this.surgeryNumber,
    required this.surgeryState,
    required this.patientName,
    required this.donorName,
    required this.hospitalName,
    required this.date,
  });

  factory SurgeryUiModel.fromJson(Map<String, dynamic> json) {
    return SurgeryUiModel(
      surgeryName: json[""],
      surgeryNumber: json["surgeryNumber"],
      patientName: json["patientName"],
      donorName: json["donorName"],
      hospitalName: json["hospitalName"],
      date: json["date"],
      surgeryState: json["surgeryState"],
    );
  }
}
