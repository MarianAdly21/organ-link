class SurgeryListApiModel {
  final String surgeryName;
  final String surgeryNumber;
  final String surgeryState;
  final String patientName;
  final String donorName;
  final String department;
  final String date;
  final int duration;
  final int id;

  SurgeryListApiModel({
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

  factory SurgeryListApiModel.fromJson(Map<String, dynamic> json) {
    return SurgeryListApiModel(
      surgeryName: json["surgery_name"],
      surgeryNumber: json["surgery_number"],
      surgeryState: json["status"],
      patientName: json["organ_matching_detail"]["patient_detail"]["full_name"],
      donorName: json["organ_matching_detail"]["donor_detail"]["full_name"],
      department: json["department"],
      date: json["scheduled_date"],
      duration: json["duration"],
      id: json["id"],
    );
  }
}
