class SurgeryApiModel {
  final String surgeryName;
  final String surgeryNumber;
  final String surgeryState;
  final String patientName;
  final String donorName;
  final String department;
  final String date;
  final int id;

  SurgeryApiModel({
    required this.surgeryName,
    required this.surgeryNumber,
    required this.surgeryState,
    required this.patientName,
    required this.donorName,
    required this.department,
    required this.date,
    required this.id,
  });

  factory SurgeryApiModel.fromJson(Map<String, dynamic> json) {
    return SurgeryApiModel(
      surgeryName: json["surgery_name"],
      surgeryNumber: json["surgery_number"],
      surgeryState: json["status"],
      patientName: json["organ_matching_detail"]["patient_detail"]["full_name"],
      donorName: json["organ_matching_detail"]["donor_detail"]["full_name"],
      department: json["department"],
      date: json["scheduled_date"],
      id: json["id"],
    );
  }
}
