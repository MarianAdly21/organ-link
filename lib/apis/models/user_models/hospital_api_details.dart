class HospitalApiDetails {
  final String hospitalName;
  final String city;
  final String location;
  final String emergencyPhone;
  final String minaPhone;
  final String email;
  final String workingHours;

  HospitalApiDetails({
    required this.hospitalName,
    required this.city,
    required this.location,
    required this.emergencyPhone,
    required this.minaPhone,
    required this.email,
    required this.workingHours,
  });

  factory HospitalApiDetails.formJson(Map<String, dynamic> json) {
    return HospitalApiDetails(
      hospitalName: json["name"],
      city: json["city"],
      location: json["location"],
      emergencyPhone: json["emergency_phone"],
      minaPhone: json["phone"],
      email: json["email"],
      workingHours: json["working_hours"],
    );
  }
}

