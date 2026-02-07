class SurgeryDetailsUiModel {
  final String surgeryNumber;
  final String organType;
  final String responsibleSurgeon;
  final String department;
  final String? date;
  final String surgeryStatus;
  final String patientName;
  final String patientFileNumber;
  final String donorName;
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
  });
}
