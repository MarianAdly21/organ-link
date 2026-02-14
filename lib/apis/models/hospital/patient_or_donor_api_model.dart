class PatientOrDonorApiModel {
  final String fullName;
  final DateTime age;
  final String bloodType;
  final String organ;
  final String status;
  final String priority;
  // final String healthStatus;

  PatientOrDonorApiModel({
    required this.fullName,
    required this.age,
    required this.bloodType,
    required this.organ,
    required this.status,
   required this.priority,
   //required this.healthStatus,
  });
  factory PatientOrDonorApiModel.formJson(Map<String, dynamic> json) {
    return PatientOrDonorApiModel(
      fullName: json["full_name"],
      age: DateTime.parse(json["birthdate"]),
      bloodType: json["blood_type"],
      organ: json["organ_needed"] ?? json["organ_available"] ,
      status: json["status"],
      priority: json["priority"]?["level"] ?? "أولوية عالية",
      
    );
  }
}
