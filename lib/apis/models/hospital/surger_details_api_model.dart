class SurgerDetailsApiModel {
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

  SurgerDetailsApiModel({
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
  factory SurgerDetailsApiModel.formJson(Map<String, dynamic> json) {
    return SurgerDetailsApiModel(
      surgeryNumber: json["surgery_number"],
      organType: json["organ_matching_detail"]["organ_type"],
      responsibleSurgeon: json["doctor_detail"]["name"],
      department: json["department"],
      date: json["scheduled_date"],
      surgeryStatus: json["status"],
      patientName: json["organ_matching_detail"]["patient_detail"]["full_name"],
      patientFileNumber: "p001",
      donorName: json["organ_matching_detail"]["donor_detail"]["full_name"],
      donorNameFileNumber: "p004",
      patientId: json["organ_matching_detail"]["patient_detail"]["id"],
      donorId: json["organ_matching_detail"]["donor_detail"]["id"],
    );
  }
}
